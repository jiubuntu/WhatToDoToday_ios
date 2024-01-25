//
//  ToDoListCell.swift
//  WhatToDoToday_ios
//
//  Created by 김지우 on 1/17/24.
//

import UIKit

final class ToDoListCell: UITableViewCell {
    // MARK: - 할 일의 상태표시를 보여주는 뷰
    lazy var toDoMark = {
        let view = UIView()
        view.layer.cornerRadius = 7.5
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toDoMarkTap))
        view.addGestureRecognizer(tapGesture)
        view.backgroundColor = #colorLiteral(red: 0.5023792982, green: 0.807808578, blue: 0.8718705773, alpha: 1)
        return view
    }()
    
    // MARK: - 할 일 내용
    let toDoTitle = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.black
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupLayout()
        setConstrains()
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // todoMark를 원모양으로 만드는 코드
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
//        contentView.layer.cornerRadius = toDoMark.bounds.width / 2
        contentView.layer.masksToBounds = true
        
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
//        layer.shadowColor = UIColor.lightGray.cgColor
//        layer.shadowOpacity = 0.2
//        layer.shadowRadius = 8
        contentView.addSubview(toDoMark)
        contentView.addSubview(toDoTitle)
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = #colorLiteral(red: 0.7764706016, green: 0.7764706016, blue: 0.7764706016, alpha: 1)
//        contentView.layer.cornerRadius = 8
        
    }
    
    func setConstrains() {
        setToDoMark()
        setToDoTitle()
    }
    
    func setToDoMark() {
        toDoMark.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toDoMark.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            toDoMark.widthAnchor.constraint(equalToConstant: 15),
            toDoMark.heightAnchor.constraint(equalToConstant: 15),
            toDoMark.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
    }
    
    func setToDoTitle() {
        toDoTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toDoTitle.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            toDoTitle.centerYAnchor.constraint(equalTo: toDoMark.centerYAnchor),
            toDoTitle.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    
    // MARK: - toDoMark를 눌렀을때 동작하는 함수
    @objc func toDoMarkTap() {
        print("tab")
    }
}
