# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/roadrunner/roadrunner-0.9.1.ebuild,v 1.5 2005/10/07 08:47:58 dragonheart Exp $


# EBuild details
DESCRIPTION="RoadRunner library provides API for using Blocks Extensible Exchange Protocol"
HOMEPAGE="http://rr.codefactory.se"
SRC_URI="ftp://ftp.codefactory.se/pub/RoadRunner/source/roadrunner/roadrunner-${PV}.tar.gz"
LICENSE="Roadrunner"
SLOT="0"
KEYWORDS="x86 ppc"

# static	= also build a static library
# doc		= include documentation
IUSE="static doc"

RDEPEND=">=dev-libs/glib-2.2.1
	>=dev-libs/libxml2-2.5.11"

DEPEND="sys-apps/sed
	>=dev-libs/glib-2.2.1
	>=dev-libs/libxml2-2.5.11
	>=dev-util/pkgconfig-0.15.0
	doc? ( dev-util/gtk-doc )"

src_compile() {
	econf \
		$(use_enable static) \
		$(use_enable doc gtk-doc) \
		|| die "configure failed"

	emake || die "emake failed"
}

src_install() {
	# Seems that the Makefiles are OK
	emake DESTDIR=${D} install || die
}

