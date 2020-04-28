//
//  PickerBlurView.swift
//  CS-Living
//
//  Created by doanntuann on 4/28/20.
//

import Foundation
import UIKit


protocol PickerBlurViewDelegate: class {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, value: String?)
}

class PickerBlurView: UIView {
    weak var delegate: PickerBlurViewDelegate?
    @IBOutlet private weak var blurView: UIVisualEffectView!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet private weak var pickerView: UIView!
    @IBOutlet private weak var doneButton: UIButton!
    @IBOutlet private weak var doneView: UIView!
    @IBOutlet private weak var cancelButton: UIButton!
    
    fileprivate var pickerData: [String?] = []
    private var itemValue: String?
    private var itemRow: Int?
    private var itemPicker: UIPickerView?
    var isShowing: Bool = false
    var selectedRow: Int? {
        didSet {
            guard let selectedRow = self.selectedRow else { return }
            self.picker.selectRow(selectedRow, inComponent: 0, animated: true)
            itemRow = selectedRow
            if self.pickerData.count > 0 {
                itemValue = self.pickerData[selectedRow]
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupPickerView()
    }
    
    private func setupPickerView() {
        blurView.alpha = 0
        picker.dataSource = self
        picker.delegate = self
        cancelButton.isHidden = true
        self.addTapGesture(blurView)
    }
    
    func configData(_ data: [String?]) {
        pickerData = data
        if data.count > 0 {
            self.selectedRow = 0
            self.itemRow = 0
            self.picker.isHidden = false
        } else {
            self.picker.isHidden = true
            self.itemValue = nil
        }
        picker.reloadAllComponents()
    }
    
    func showPickerView(isShowCancelButton: Bool? = nil) {
        self.isShowing = true
        if isShowCancelButton == true {
            cancelButton.isHidden = false
            doneButton.setTitle("Ok", for: .normal)
            cancelButton.setTitle("Hủy", for: .normal)
        } else {
            doneButton.setTitle("Ok", for: .normal)
            cancelButton.isHidden = true
        }
        UIApplication.shared.keyWindow?.addSubview(self)
        self.frame = UIApplication.shared.keyWindow?.bounds ?? .zero
        var pickerFrame = pickerView.frame
        pickerFrame.origin.y = (ScreenHeight + pickerFrame.size.height)
        pickerView.frame = pickerFrame
        UIView.animate(withDuration: 0.2, animations: {
            pickerFrame.origin.y = ScreenHeight - pickerFrame.size.height
            self.pickerView.frame = pickerFrame
            self.blurView.alpha = 1
        })
    }
    
    @objc func hidePickerView() {
        self.isShowing = false
        var pickerFrame = pickerView.frame
        UIView.animate(withDuration: 0.2, animations: {
            pickerFrame.origin.y = ScreenHeight + pickerFrame.size.height
            self.pickerView.frame = pickerFrame
            self.blurView.alpha = 0
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    fileprivate func addTapGesture(_ inView: UIView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(PickerBlurView.hidePickerView))
        inView.addGestureRecognizer(tapGesture)
    }

    @IBAction func onDone(_ sender: Any) {
        hidePickerView()
        guard let itemPicker = self.itemPicker else {
            let picker = UIPickerView()
            picker.tag = self.picker.tag
            if let itemRow = self.itemRow {
                self.delegate?.pickerView(picker, didSelectRow: itemRow, value: itemValue)
            }
            return
        }
        if let itemRow = self.itemRow {
            self.delegate?.pickerView(itemPicker, didSelectRow: itemRow, value: itemValue)
        }
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.hidePickerView()
    }
}

// MARK: - UIPickerViewDataSource Functions
extension PickerBlurView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let itemValue = self.pickerData[row]
        return itemValue
    }
}

// MARK: - UIPickerViewDelegate Functions
extension PickerBlurView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row < self.pickerData.count {
            itemValue = self.pickerData[row]
            itemRow = row
            itemPicker = pickerView
            selectedRow = row
        }
    }
}
