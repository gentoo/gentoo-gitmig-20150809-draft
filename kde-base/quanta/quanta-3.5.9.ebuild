# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/quanta/quanta-3.5.9.ebuild,v 1.6 2008/05/14 11:16:13 corsair Exp $
KMNAME=kdewebdev
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="KDE: Quanta Plus Web Development Environment"
KEYWORDS="alpha ~amd64 hppa ia64 ppc ppc64 sparc ~x86 ~x86-fbsd"
IUSE="doc kdehiddenvisibility"

DEPEND="dev-libs/libxslt
	dev-libs/libxml2"
RDEPEND="${RDEPEND}
	doc? ( app-doc/quanta-docs )"

KMCOMPILEONLY=lib

# TODO: check why this wasn't needed back in the monolithic ebuild
src_compile () {
	myconf="--with-extra-includes=$(xml2-config --cflags | sed -e 's:^-I::')"
	kde-meta_src_compile
}

pkg_postinst() {
	kde_pkg_postinst

	echo
	elog "${P} has some optional dependencies which you might want to emerge:"
	elog "- app-text/htmltidy for HTML syntax checking."
	elog "- app-crypt/gnupg for previewing browser configuration."
	elog "- kde-base/kompare for comparing files by content."
	elog "- kde-base/cervisia for enabling the CVS management plugin."
	elog "- kde-base/kfilereplace for searching and replacing in files."
	elog "- kde-base/kimagemapeditor for editing HTML image maps."
	elog "- kde-base/klinkstatus for link validity checking."
	elog "- kde-base/kxsldbg for XSLT debugging."
	elog "- kde-base/kommander for the QuickStart dialogue and other scripted dialogues."
	echo
}
