# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/rskkserv/rskkserv-2.94.12a.ebuild,v 1.3 2004/04/06 03:59:15 vapier Exp $

inherit eutils

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

S=${WORKDIR}/${P}

src_unpack() {

	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
	epatch ${FILESDIR}/${PN}-skk-jisyo-extra.diff
}

src_compile() {

	mv rskkserv.conf.in rskkserv.conf.in.tmp
	sed -e "s%@skkdicdir@%/usr/share/skk%g" \
		rskkserv.conf.in.tmp > rskkserv.conf.in
	econf --with-dicfile=/usr/share/skk/SKK-JISYO.L \
		--with-cachedir=/var/lib/rskkserv \
		--with-piddir=/var/run \
		--with-logdir=/var/log \
		|| die
	emake || die
}

src_install() {

	keepdir /var/lib/rskkserv
	make DESTDIR=${D} install || die

	exeinto /etc/init.d
	newexe ${FILESDIR}/rskkserv.initd rskkserv || die

	dodoc ChangeLog rskkserv.conf.sample
	newdoc doc/README.old README
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
