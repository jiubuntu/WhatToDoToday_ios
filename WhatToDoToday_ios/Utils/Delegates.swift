import UIKit



protocol ToDoDetailDelegate: AnyObject {
    // MARK: - Todo 데이터를 업데이트하고 원래화면으로 돌아왔을때, 원래화면을 업데이트 하기 위함
    func didUpdateToDo()
}


protocol ToDoListCellDelegate: AnyObject {
    // MARK: - 테이블뷰 셀에서 toDoMark를 눌렀을때의 예외처리를 위한 alert창 표시
    func showAlert()
}

protocol GaugeChartDelegate: AnyObject {
    // MARK: - ToDo 데이터를 업데이트 할때 게이지 차트의 데이터를 업데이트 하는 함수
    func updateGaugeData()
}

protocol GaugeChartDelegateForCell: AnyObject {
    // MARK: - ToDoMark를 탭 할때 게이지 차트의 데이터를 업데이트 하는 함수
    func toDoMarkTapped(for cell: ToDoListCell)
}
