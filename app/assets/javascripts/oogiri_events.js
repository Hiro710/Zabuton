// Turbolinksを使っているため、window.onloadを利用しない代わりにturbolinks:loadを使っている

// javascriptで一覧画面にマウスを置いた時に部分的に色で見た目を変化させる
/*

document.addEventListener('turbolinks:load', function() {
  document.querySelectorAll('td').forEach(function(td) {
    td.addEventListener('mouseover', function(e) {
      e.currentTarget.style.backgroundColor = '#eff';
    });

    td.addEventListener('mouseout', function(e) {
      e.currentTarget.style.backgroundColor = '';
    });
  });
});

// Ajaxとjavascriptで削除したイベントを非表示にする
document.addEventListener('turbolinks:load', function() {
  document.querySelectorAll('.delete').forEach(function(a) {
    a.addEventListener('ajax:success', function() {
// 親要素を辿って処理を記述することは、変化しやすいHTMLの構造に強く依存する為推奨できない
      var td = a.parentNode;
      var tr = td.parentNode;
      tr.style.display = 'none';
    });
  });
});

*/
