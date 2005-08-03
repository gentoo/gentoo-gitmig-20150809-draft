# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/rskkserv/rskkserv-2.95.3-r1.ebuild,v 1.4 2005/08/03 19:51:18 kloeri Exp $

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
	einstall || die

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
	einfo
	einfo "If you want to add auxiliary dictionaries (e.g. SKK-JISYO.JIS2,"
	einfo "SKK-JISYO.jinmei, SKK-JISYO.2ch and so on) you need to emerge"
	einfo "app-i18n/skk-jisyo-extra and uncomment dictionary entries in"
	einfo "/etc/rskkserv.conf manually."
	#einfo "See /usr/share/doc/${PF}/rskkserv.conf.sample.gz"
	#einfo "for an example of multiple dictionaries."
	einfo
	draw_line
	einfo
	einfo "If you are upgrading from 2.94.x, you may want to use"
	einfo "/usr/share/doc/${PF}/conf-o2n.rb to convert configuration"
	einfo "file into new format."
	einfo
}
