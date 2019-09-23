//
//  ViewController.swift
//  SeaWorld
//
//  Created by Andrey Rodionov on 11/09/2019.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

class MainScreenVC: UIViewController {

    // MARK: - Properties

    private var cells: [UIImageView] = []

    private let worldProcessor = Processor()

    private let verticalStackView: UIStackView = {
        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.spacing = 0
        verticalStack.distribution = .fillEqually
        return verticalStack
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }

    // MARK: - Configure subviews

    private func setupSubviews() {
        view.addSubview(verticalStackView)

        for _ in 0...worldProcessor.world.yCount - 1 {
            let horizontalStack = createHorizontalStackView()
            for _ in 0...worldProcessor.world.xCount - 1 {
                let cell = createCellView()
                cells.append(cell)
                let array: [UIImage] = [#imageLiteral(resourceName: "orca"), #imageLiteral(resourceName: "penguin")]
                cell.image = array.randomElement()
                horizontalStack.addArrangedSubview(cell)
            }
            verticalStackView.addArrangedSubview(horizontalStack)
        }
        setupConstraints()
    }

    private func setupConstraints() {
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        verticalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        verticalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    private func createCellView() -> UIImageView {
        let cellView = UIImageView()
        cellView.layer.borderColor = UIColor.black.cgColor
        cellView.layer.borderWidth = 1
        cellView.contentMode = .scaleAspectFit
        cellView.backgroundColor = .blue
        return cellView
    }

    private func createHorizontalStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        return stackView
    }

    // MARK: - Actions

    @objc
    private func handleTap() {
        worldProcessor.turn()
        for (index, cell) in cells.enumerated() {
            let entity = worldProcessor.world.cells[index]
            let image: UIImage?
            switch entity {
            case is Orca:
                image = #imageLiteral(resourceName: "orca")
            case is Penguin:
                image = #imageLiteral(resourceName: "penguin")
            default:
                image = nil
            }
            cell.image = image
        }
    }

}
