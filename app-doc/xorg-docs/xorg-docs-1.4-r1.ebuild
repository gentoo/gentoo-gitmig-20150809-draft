# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/xorg-docs/xorg-docs-1.4-r1.ebuild,v 1.13 2009/05/04 15:51:28 ssuominen Exp $

# Must be before x-modular eclass is inherited
SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org docs"

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"

RDEPEND=""
DEPEND="${RDEPEND}
	>=x11-misc/util-macros-1.1.5
	doc? (
		>=app-doc/xorg-sgml-doctools-1.2
		app-text/docbook-sgml-utils
		~app-text/docbook-sgml-dtd-4.2
		app-text/docbook-dsssl-stylesheets
	)"

IUSE="doc"

PATCHES="${FILESDIR}/1.1-allow_manpages_only.patch
	${FILESDIR}/65533-URL-interpolation.patch
	${FILESDIR}/1.4-sgml-fixes.patch
	${FILESDIR}/1.4-rename-security.man.patch.bz2"

pkg_setup() {
	CONFIGURE_OPTIONS="--with-x11docdir=/usr/share/doc/${PF}
		$(use_enable doc non-man-docs)
		$(use_enable doc txt)
		$(use_enable doc pdf)
		$(use_enable doc html)
		$(use_enable doc ps)"

	# parallel build broken -- https://bugs.gentoo.org/show_bug.cgi?id=170798
}

MAKEOPTS="${MAKEOPTS} -j1"
