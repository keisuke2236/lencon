<div class="jumbotron">
    <div class="container">
        <h1><?= $candidate['name'] ?></h1>
    </div>
</div>
<div class="container">
    <div class="row">
        <div id="info" class="jumbotron">
            <h2>得票数</h2>
            <p id="votes"><?= $votes ?></p>
            <h2>政党</h2>
            <p id="party"><?= $candidate['political_party'] ?></p>
            <h2>性別</h2>
            <p id="sex"><?= $candidate['sex'] ?></p>
            <h2>支持者の声</h2>
            <ul id="voice">
                <?php foreach ($keywords as $keyword) { ?>
                    <li><?= $keyword ?></li>
                <?php } ?>
            </ul>
        </div>
    </div>
</div>
