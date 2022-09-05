//
//  PickerTableViewCell.swift
//  Mars
//
//  Created by Robson Lima Lopes on 25/08/22.
//

import UIKit

class PickerTableViewCell: UITableViewCell {
    private lazy var picker: UIPickerView = {
        return UIPickerView(frame: .zero)
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.viewBackgroundColor
        applyViewCode()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension PickerTableViewCell: ViewCodeConfiguration {
    func buildHierarchy() {
        self.contentView.addSubview(picker)
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            picker.topAnchor.constraint(
                equalTo: self.contentView.topAnchor
            ),
            picker.bottomAnchor.constraint(
                equalTo: self.contentView.bottomAnchor
            ),
            picker.widthAnchor.constraint(
                equalTo: self.contentView.widthAnchor,
                multiplier: 0.9
            ),
            picker.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
        ])
    }
    func configureViews() {
        picker.delegate = self
        picker.dataSource = self
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.setValue(UIColor.white, forKeyPath: "textColor")
    }
}

extension PickerTableViewCell: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CameraFullName.allCases.count
    }
    func pickerView(
        _ pickerView: UIPickerView,
        titleForRow rowTitle: Int,
        forComponent component: Int
    ) -> String? {
        let selected: CameraFullName = CameraFullName.allCases[rowTitle]
        let rowValue = selected.rawValue
        switch selected {
        case .chemistryAndCameraComplex:
            CameraModel.camera = .chemcam
            CameraModel.cameraWasChanged = true
        case .frontHazardAvoidanceCamera:
            CameraModel.camera = .fhaz
            CameraModel.cameraWasChanged = true
        case .mastCamera:
            CameraModel.camera = .mast
            CameraModel.cameraWasChanged = true
        case .navigationCamera:
            CameraModel.camera = .navcam
            CameraModel.cameraWasChanged = true
        case .rearHazardAvoidanceCamera:
            CameraModel.camera = .rhaz
            CameraModel.cameraWasChanged = true
        }
       return rowValue
    }
}
