# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/rskkserv/rskkserv-2.95.3-r1.ebuild,v 1.6 2007/01/05 16:23:50 flameeyes Exp $

inherit ruby eutils

DESCRIPTION="rskkserv is an alternative version of skkserv implemented by Ruby"
HOMEPAGE="http://raa.ruby-lang.org/list.rhtml?name=rskkserv"
SRC_URI="http://www.unixuser.org/~ysjj/rskkserv/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~ppc x86"
IUSE=""

DEPEND="dev-ruby/ruby-tcpwrap"
RDEPEND="${DEPEND}
	app-i18n/skk-jisyo"
PROVIDE="virtual/skkserv"
USE_RUBY="ruby16 ruby18 ruby19"

src_compile() {
	ruby -i -pe "gsub(/with_RUBY/,'with_ruby')" configure || die
	econf \
		--with-dicfile=/usr/share/skk/SKK-JISYO.L \
		--with-cachedir=/var/lib/rskkserv \
		--with-piddir=/var/run \
		--with-logdir=/var/log \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	keepdir /var/lib/rskkserv
	emake -j1 DESTDIR="${D}" install || die "emake install failed"

	exeinto /etc/init.d
	newexe ${FILESDIR}/rskkserv-2.95.initd rskkserv || die

	dodoc ChangeLog
	cd doc
	dodoc rskkserv.conf.sample
	newdoc README.old README
	insinto /usr/share/doc/${PF}
	doins conf-o2n.rb
	newman rskkserv.1.in rskkserv.1
	insinto /usr/share/man/ja/man1
	newins rskkserv.1.ja_JP.eucJP.in rskkserv.1
}

pkg_postinst() {
	elog
	elog "If you want to add auxiliary dictionaries (e.g. SKK-JISYO.JIS2,"
	elog "SKK-JISYO.jinmei, SKK-JISYO.2ch and so on) you need to emerge"
	elog "app-i18n/skk-jisyo-extra and uncomment dictionary entries in"
	elog "/etc/rskkserv.conf manually."
	#elog "See /usr/share/doc/${PF}/rskkserv.conf.sample.gz"
	#elog "for an example of multiple dictionaries."
	elog
	draw_line
	elog
	elog "If you are upgrading from 2.94.x, you may want to use"
	elog "/usr/share/doc/${PF}/conf-o2n.rb to convert configuration"
	elog "file into new format."
	elog
}
