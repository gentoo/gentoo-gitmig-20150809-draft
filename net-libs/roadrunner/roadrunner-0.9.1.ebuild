# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/roadrunner/roadrunner-0.9.1.ebuild,v 1.2 2004/06/15 01:11:33 dragonheart Exp $


# EBuild details
DESCRIPTION="RoadRunner library provides API for using Blocks Extensible Exchange Protocol"
HOMEPAGE="http://rr.codefactory.se"
SRC_URI="ftp://ftp.codefactory.se/pub/RoadRunner/source/roadrunner/roadrunner-${PV}.tar.gz"
LICENSE="Roadrunner"
SLOT="0"
KEYWORDS="x86"

# static	= also build a static library
# doc		= include documentation
# debug		= include debug and debug-net
IUSE="static doc debug"

use debug && RESTRICT="${RESTRICT} nostrip"

RDEPEND=">=dev-libs/glib-2.2.1
	>=dev-libs/libxml2-2.5.11"

DEPEND=">=sys-devel/automake-1.4
	sys-devel/libtool
	sys-devel/gcc
	sys-apps/sed
	>=dev-libs/glib-2.2.1
	>=dev-libs/libxml2-2.5.11
	>=dev-util/pkgconfig-0.15.0
	doc? ( dev-util/gtk-doc )"

src_compile() {
	econf \
		`use_enable static` \
		`use_enable debug` \
		`use_enable debug debug-net` \
		`use_enable doc gtk-doc` \
		|| die "configure failed"

	emake || die "emake failed"
}

src_install() {
	# Seems that the Makefiles are OK
	emake DESTDIR=${D} install || die
}

