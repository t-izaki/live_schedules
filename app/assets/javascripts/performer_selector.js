$(function() {
    let performer_list = $('#js-performer_list').data('json');
    let schedules = $('#js-schedules').data('json');

    let performers = new Bloodhound({
        datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name'),
        queryTokenizer: Bloodhound.tokenizers.whitespace,
        local: performer_list,
    });
    performers.initialize();

    let elt = $('.performer_selector');
    $('.performer_selector').each(function(i, _e){
        let target = $(this);
        target.tagsinput({
            itemValue: 'id',
            itemText: 'name',
            typeaheadjs: {
                name: 'performers',
                displayKey: 'name',
                source: performers.ttAdapter()
            }
        });

        schedules[i].performers.forEach(function(element) {
            target.tagsinput('add', element);
        });
    });
});
