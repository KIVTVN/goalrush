const db = require('../utils/postgres');

/* GET ONE user  */
module.exports = async (req, res) => {
  const { rows } = await db.query(
    `SELECT * FROM parties WHERE id = '${req.params.id}'`,
  );

  if (rows.length !== 0) {
    const home_team = await db.query(
      `Select name from teams where id='${rows[0].home_team}'`,
    );

    const away_team = await db.query(
      `Select name from teams where id='${rows[0].away_team}'`,
    );
    res.status(200).json({
      status: 'Success',
      party: {
        home_team: home_team.rows[0].name,
        away_team: away_team.rows[0].name,
        score_home_team: rows[0].score_home_team,
        score_away_team: rows[0].score_away_team,
        home_team_rating: rows[0].home_team_rating,
        away_team_rating: rows[0].away_team_rating,
        draft_rating: rows[0].draft_rating,
        result: rows[0].result,
        date: rows[0].date,
      },
    });
  } else {
    res.status(404).json({
      status: 'Error',
      message: 'Party not found',
    });
  }
};
