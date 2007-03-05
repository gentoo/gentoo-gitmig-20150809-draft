# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/monotone/monotone-0.25.ebuild,v 1.3 2007/03/05 04:00:00 genone Exp $

inherit elisp-common flag-o-matic

DESCRIPTION="Monotone Distributed Version Control System"
HOMEPAGE="http://www.venge.net/monotone/"
SRC_URI="http://www.venge.net/${PN}/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"

IUSE="doc emacs ipv6 nls"

RDEPEND=">=dev-libs/boost-1.32
	sys-libs/zlib
	emacs? ( virtual/emacs )"

DEPEND="${RDEPEND}
	>=sys-devel/gcc-3.2
	nls? ( >=sys-devel/gettext-0.11.5 )
	doc? ( sys-apps/texinfo )"

SITEFILE="30monotone-gentoo.el"


src_compile() {
	local myconf="$(use_enable nls) \
		$(use_enable ipv6)"

	# more aggressive optimizations cause trouble with the crypto library
	strip-flags
	append-flags $(test-flags -fno-stack-protector-all -fno-stack-protector)
	append-flags -fno-strict-aliasing -fno-omit-frame-pointer

	econf ${myconf} || die "configure failed"
	emake || die "Compilation failed"

	if use doc; then
		make html || die 'html compilation failed'
	fi

	use emacs && elisp-compile contrib/*.el
}

src_test() {
	make check || die "self test failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"

	if use doc; then
		dohtml -r html/*
		dohtml -r figures
	fi

	if use emacs; then
		elisp-install ${PN} contrib/*.{el,elc}
		elisp-site-file-install ${FILESDIR}/${SITEFILE}
	fi

	dodoc ABOUT-NLS AUTHORS ChangeLog NEWS README* UPGRADE
}

pkg_postinst() {
	use emacs && elisp-site-regen

	elog
	elog "If you are upgrading from:"
	elog "  - 0.23 or earlier: keys are now stored in ~/.monotone/keys. You"
	elog "    must run 'db migrate' against each of your databases; this "
	elog "    will automatically migrate the keys. Command line syntax for"
	elog "    'serve' has changed; please adjust startup scripts accordingly."
	elog "  - 0.21 or earlier: hooks governing netsync read permission have"
	elog "    changed again; see /usr/share/doc/${PF}/NEWS.gz"
	elog "  - 0.20 or earlier: you need to run 'db migrate' against each of"
	elog "    your databases."
	elog
	elog "For more details and instructions to upgrade from previous versions,"
	elog "please read /usr/share/doc/${PF}/UPGRADE.gz"
	elog
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
