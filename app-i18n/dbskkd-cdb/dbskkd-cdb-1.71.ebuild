# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/dbskkd-cdb/dbskkd-cdb-1.71.ebuild,v 1.5 2008/04/12 11:27:25 nixnut Exp $

inherit eutils multilib toolchain-funcs

MY_P="${P}dev"
DESCRIPTION="Yet another Dictionary server for the SKK Japanese-input software"
HOMEPAGE="http://www.ne.jp/asahi/bdx/info/software/jp-dbskkd.html"
SRC_URI="http://www.ne.jp/asahi/bdx/info/software/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 ppc sparc x86"
IUSE=""

DEPEND="dev-db/cdb
	|| (
		>=app-i18n/skk-jisyo-200705
		app-i18n/skk-jisyo-cdb
	)"
RDEPEND="sys-process/daemontools
	sys-apps/ucspi-tcp"
PROVIDE="virtual/skkserv"

S="${WORKDIR}/${MY_P}"

JISYO_FILE="/usr/share/skk/SKK-JISYO.L.cdb"

pkg_setup() {
	if has_version '>=app-i18n/skk-jisyo-200705' && ! built_with_use '>=app-i18n/skk-jisyo-200705' cdb ; then
		eerror "multiskkserv requires skk-jisyo to be built with cdb support. Please add"
		eerror "'cdb' to your USE flags, and re-emerge app-i18n/skk-jisyo."
		die "Missing cdb USE flag."
	fi
	# from READMEJP
	enewuser dbskkd -1 -1 -1 nofiles
	enewuser svlog -1 -1 -1 nofiles
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e 's/IP\.ADD\.RE\.SS/127.0.0.1/' \
		-e 's:/usr/local:/usr:' \
		run.example || die
}

src_compile() {
	$(tc-getCC) ${CFLAGS} \
		-DSERVERDIR="\"/service/dbskkd-cdb/root\"" \
		-o dbskkd-cdb dbskkd-cdb.c /usr/$(get_libdir)/{cdb,unix,byte}.a || die
}

src_install() {
	exeinto /usr/libexec; doexe dbskkd-cdb || die
	dodoc CHANGES READMEJP

	exeinto /var/dbskkd-cdb/service; newexe run.example run || die
	exeinto /var/dbskkd-cdb/service/log; newexe run.log.example run || die
	keepdir /var/dbskkd-cdb/service/log/main
	insinto /var/dbskkd-cdb/service/root; doins "${JISYO_FILE}"
	fperms +t /var/dbskkd-cdb/service
	fowners -R svlog:nofiles /var/dbskkd-cdb/service/log
}

pkg_postinst() {
	elog "To start dbskkd-cdb at boot you have to enable the /etc/init.d/svscan"
	elog "rc file and create the following link:"
	elog
	elog "# ln -sf /var/dbskkd-cdb/service /service/dbskkd-cdb"
	elog
}
