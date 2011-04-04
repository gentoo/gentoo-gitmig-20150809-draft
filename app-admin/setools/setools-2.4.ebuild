# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/setools/setools-2.4.ebuild,v 1.5 2011/04/04 21:44:07 blueness Exp $

inherit eutils

DESCRIPTION="SELinux policy tools"
HOMEPAGE="http://www.tresys.com/selinux/selinux_policy_tools.shtml"
SRC_URI="http://oss.tresys.com/projects/setools/chrome/site/dists/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="X debug selinux"

#S="${WORKDIR}/${PN}"

DEPEND="sys-devel/bison
	sys-devel/flex
	dev-libs/libxml2
	dev-util/pkgconfig
	selinux? ( sys-libs/libselinux )
	X? (
		dev-lang/tk
		>=gnome-base/libglade-2.0
	)"

RDEPEND="dev-libs/libxml2
	selinux? ( sys-libs/libselinux )
	X? (
		dev-lang/tk
		>=dev-tcltk/bwidget-1.4.1
		>=gnome-base/libglade-2.0
	)"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/apol_tcl_fc.c.diff"

	# enable debug if requested
	useq debug && sed -i -e '/^DEBUG/s/0/1/' "${S}/Makefile"

	# dont do findcon, replcon, searchcon, or indexcon if USE=-selinux
	if ! useq selinux; then
		sed -i -e '/^USE_LIBSELINUX/s/1/0/' "${S}/Makefile"
		sed -i -e '/^SE_CMDS/s/replcon//' \
			-e '/^SE_CMDS/s/findcon//' \
			-e '/^SE_CMDS/s/searchcon//' \
			-e '/^SE_CMDS/s/indexcon//' "${S}/secmds/Makefile"

		# sechecker won't compile w/o libselinux
		sed -i -e '/^all-nogui/s/sechecker//' "${S}/Makefile"
		sed -i -r -e '/^install-sechecker/!s/install-sechecker//' "${S}/Makefile"
	fi
}

src_compile() {
	if useq X; then
		make all || die
	else
		make all-nogui || die
	fi
}

src_install() {
	# some of the Makefiles are broken, and will fail
	# if ${D}/usr/bin is nonexistant
	dodir /usr/bin

	if use X; then
		make DESTDIR="${D}" install || die "install failed."
	else
		make DESTDIR="${D}" install-nogui || die "install failed."
	fi
}
