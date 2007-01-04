# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql-slotted/mysql-slotted-5.1.15_alpha-r90.ebuild,v 1.2 2007/01/04 20:53:15 vivo Exp $

MY_EXTRAS_VER="latest"
SERVER_URI=""
PBXT_VERSION="0.9.73-beta"

inherit mysql

#REMEMBER!!!: update also eclass/mysql*.eclass prior to commit
KEYWORDS="~amd64 ~x86"

src_test() {

	make check || die "make check failed"
	if ! useq "minimal" ; then
		cd "${S}/mysql-test"
		einfo ">>> Test phase [test]: ${CATEGORY}/${PF}"
		local retstatus
		local t
		local testopts="--force"

		# sandbox make ndbd zombie
		hasq "sandbox" ${FEATURES} && testopts="${testopts} --skip-ndb"

		addpredict /this-dir-does-not-exist/t9.MYI

		# mysqladmin start before dir creation
		mkdir ${S}/mysql-test/var{,/log}

		if [[ ${UID} -eq 0 ]] ; then
			mysql_disable_test  "im_cmd_line"          "fail as root"
			mysql_disable_test  "im_daemon_life_cycle" "fail as root"
			mysql_disable_test  "im_instance_conf"     "fail as root"
			mysql_disable_test  "im_life_cycle"        "fail as root"
			mysql_disable_test  "im_options"           "fail as root"
			mysql_disable_test  "im_utils"             "fail as root"
			mysql_disable_test  "trigger"              "fail as root"
		fi

		useq "extraengine" && mysql_disable_test "federated" "fail with extraengine"

		mysql_disable_test "view" "FIXME: fail because now we are in year 2007"

		# from Makefile.am:
		retstatus=1
		./mysql-test-run.pl ${testopts} --mysqld=--binlog-format=mixed \
		&& ./mysql-test-run.pl ${testopts} --ps-protocol --mysqld=--binlog-format=row \
		&& ./mysql-test-run.pl ${testopts} --ps-protocol --mysqld=--binlog-format=mixed \
		&& ./mysql-test-run.pl ${testopts} --mysqld=--binlog-format=row \
		&& retstatus=0

		# Just to be sure ;)
		pkill -9 -f "${S}/ndb" 2>/dev/null
		pkill -9 -f "${S}/sql" 2>/dev/null
		[[ $retstatus -eq 0 ]] || die "make test failed"
	else
		einfo "Skipping server tests due to minimal build."
	fi
}
