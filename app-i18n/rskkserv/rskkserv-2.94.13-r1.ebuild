# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/rskkserv/rskkserv-2.94.13-r1.ebuild,v 1.2 2004/03/27 16:27:06 usata Exp $

IUSE=""

inherit ruby

DESCRIPTION="rskkserv is an alternative version of skkserv implemented by Ruby"
HOMEPAGE="http://raa.ruby-lang.org/list.rhtml?name=rskkserv"
SRC_URI="http://www.unixuser.org/~ysjj/rskkserv/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="dev-lang/ruby
	dev-ruby/ruby-tcpwrap"
RDEPEND="${DEPEND}
	app-i18n/skk-jisyo"
PROVIDE="virtual/skkserv"
USE_RUBY="ruby16 ruby18 ruby19"

S=${WORKDIR}/${PN}-cvs

src_unpack() {

	unpack ${P}.tar.gz

	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
	epatch ${FILESDIR}/${P}-conf-gentoo.diff

	sed -i -e "s%with_RUBY%with_ruby%g" configure
	sed -i -e "s%@datadir@%/usr/share%g" rskkserv.conf.in
	sed -i -e "s%@VERSION@%${PV}%g" doc/*.in
}

src_compile() {

	EXTRA_ECONF="--with-dicfile=/usr/share/skk/SKK-JISYO.L
		--with-cachedir=/var/lib/rskkserv
		--with-piddir=/var/run
		--with-logdir=/var/log"

	econf || die
	emake || die
}

src_install() {

	keepdir /var/lib/rskkserv
	einstall || die

	exeinto /etc/init.d
	newexe ${FILESDIR}/rskkserv.initd rskkserv || die

	dodoc ChangeLog
	cd doc
	dodoc rskkserv.conf.sample
	newdoc README.old README
	newman rskkserv.1.in rskkserv.1
	insinto /usr/share/man/ja/man1
	newins rskkserv.1.ja_JP.eucJP.in rskkserv.1
}

pkg_postinst() {

	einfo
	einfo "If you want to add auxiliary dictionaries (e.g. SKK-JISYO.JIS2,"
	einfo "SKK-JISYO.jinmei, SKK-JISYO.2ch and so on) you need to emerge"
	einfo "app-i18n/skk-jisyo-extra and uncomment dictionary entries in"
	einfo "/etc/rskkserv.conf manually."
	#einfo "See /usr/share/doc/${PF}/rskkserv.conf.sample.gz"
	#einfo "for an example of multiple dictionaries."
	einfo
}
