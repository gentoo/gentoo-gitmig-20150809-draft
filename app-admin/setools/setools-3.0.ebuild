# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/setools/setools-3.0.ebuild,v 1.3 2007/02/02 05:11:39 pebenito Exp $

inherit autotools

DESCRIPTION="SELinux policy tools"
HOMEPAGE="http://www.tresys.com/selinux/selinux_policy_tools.shtml"
SRC_URI="http://oss.tresys.com/projects/setools/chrome/site/dists/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="X debug"

DEPEND=">=sys-libs/libsepol-1.12.27
	sys-libs/libselinux
	sys-devel/bison
	sys-devel/flex
	dev-libs/libxml2
	dev-util/pkgconfig
	X? (
		dev-lang/tk
		>=gnome-base/libglade-2.0
	)"

RDEPEND=">=sys-libs/libsepol-1.12.27
	sys-libs/libselinux
	dev-libs/libxml2
	X? (
		dev-lang/tk
		>=dev-tcltk/bwidget-1.4.1
		>=gnome-base/libglade-2.0
	)"

src_unpack() {
	unpack ${A}
	cd ${S}

	eautoreconf
}

src_compile() {
	cd ${S}

	econf \
		$(use_enable X gui) \
		$(use_enable debug)

	emake
}

src_install() {
	cd ${S}

	# some of the Makefiles are broken, and will fail
	# if ${D}/usr/bin is nonexistant
#	dodir /usr/bin

	make DESTDIR=${D} install || die "install failed."
}
