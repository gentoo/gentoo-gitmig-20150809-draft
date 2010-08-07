# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/bip/bip-0.8.5.ebuild,v 1.2 2010/08/07 16:41:44 a3li Exp $

EAPI="2"
inherit eutils autotools

DESCRIPTION="Multiuser IRC proxy with ssl support"
HOMEPAGE="http://bip.t1r.net/"
SRC_URI="http://bip.t1r.net/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug freenode noctcp ssl vim-syntax oidentd"

DEPEND="ssl? ( dev-libs/openssl )"
RDEPEND="${DEPEND}
	vim-syntax? ( || ( app-editors/vim
	app-editors/gvim ) )
	oidentd? ( >=net-misc/oidentd-2.0 )"

src_prepare() {
	epatch "${FILESDIR}/${PN}-configure.patch" || die

	eautoreconf

	if use noctcp; then
		sed -i -e '/irc_privmsg_check_ctcp(server, line);/s:^://:' src/irc.c || die
	fi

	if use freenode; then
		epatch "${FILESDIR}/${PN}-freenode.patch" || die
	fi
}

src_configure() {
	econf \
		$(use_with ssl openssl) \
		$(use_enable debug) \
		$(use_enable oidentd)
}

src_compile() {
	# Parallel make fails.
	emake -j1 || die "emake failed"
}

src_install() {
	dobin src/bip src/bipmkpw || die "dobin failed"

	dodoc AUTHORS ChangeLog README NEWS TODO || die "dodoc failed"
	newdoc samples/bip.conf bip.conf.sample || die "newdoc failed"
	doman bip.1 bip.conf.5 bipmkpw.1 || die "doman failed"

	if use vim-syntax; then
		insinto /usr/share/vim/vimfiles/syntax
		doins samples/bip.vim || die "doins failed"
		insinto /usr/share/vim/vimfiles/ftdetect
		doins "${FILESDIR}"/bip.vim || die "doins failed"
	fi
}

pkg_postinst() {
	elog 'Default configuration file is "~/.bip/bip.conf"'
	elog "You can find a sample configuration file in"
	elog "/usr/share/doc/${PF}/bip.conf.sample"
}
