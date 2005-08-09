# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/monotone/monotone-0.22.ebuild,v 1.1 2005/08/09 14:15:53 leonardop Exp $

inherit elisp-common flag-o-matic

DESCRIPTION="Monotone Distributed Version Control System"
HOMEPAGE="http://www.venge.net/monotone/"
SRC_URI="http://www.venge.net/${PN}/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE="doc emacs ipv6 nls"

RDEPEND=">=dev-libs/boost-1.32
	emacs? ( virtual/emacs )"

DEPEND="${RDEPEND}
	>=sys-devel/gcc-3.2
	nls? ( >=sys-devel/gettext-0.12.1 )
	doc? ( sys-apps/texinfo )"

SITEFILE="30monotone-gentoo.el"


src_compile() {
	local myconf="$(use_enable nls) $(use_enable ipv6)"

	# more aggressive optimizations cause trouble with the crypto library
	strip-flags
	append-flags -fno-stack-protector-all -fno-stack-protector \
		-fno-strict-aliasing

	econf ${myconf} || die "configure failed"
	emake || die "emake failed"

	use doc && make html

	use emacs && elisp-compile contrib/*.el
}

src_test() {
	make check || die "self test failed"
}

src_install() {
	make DESTDIR="${D}" install || die

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

	einfo
	einfo "If you are upgrading from:"
	einfo "  - 0.21 or earlier: hooks governing netsync read permission have"
	einfo "    changed again; see /usr/share/doc/${PF}/NEWS.gz"
	einfo "  - 0.20 or earlier: you need to run 'db migrate' against each of"
	einfo "    your databases."
	einfo "  - 0.19 or earlier: there are some command line and server"
	einfo "    configuration changes; see /usr/share/doc/${PF}/NEWS.gz"
	einfo "  - 0.18 or earlier: if you have created a ~/.monotonerc, rename"
	einfo "    it to ~/.monotone/monotonerc, so monotone will still find it."
	einfo
	einfo "For instructions to upgrade from previous versions, please read"
	einfo "/usr/share/doc/${PF}/UPGRADE.gz"
	einfo
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
