# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gstreamer/gstreamer-0.8.0.ebuild,v 1.2 2004/03/28 15:36:20 lu_zero Exp $

# FIXME : re-enable docs build
inherit eutils flag-o-matic libtool gnome2

# Create a major/minor combo for our SLOT and executables suffix
PVP=($(echo " $PV " | sed 's:[-\._]: :g'))
PV_MAJ_MIN=${PVP[0]}.${PVP[1]}

DESCRIPTION="Streaming media framework"
HOMEPAGE="http://gstreamer.sourceforge.net"
LICENSE="LGPL-2"

SLOT=${PV_MAJ_MIN}
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ia64 ~mips"
#IUSE="doc"
IUSE=""

RDEPEND=">=dev-libs/glib-2.2
	>=dev-libs/libxml2-2.4.9
	>=dev-libs/popt-1.6.3"

DEPEND="${RDEPEND}
	>=sys-devel/gettext-0.11.5
	dev-util/pkgconfig"
#	doc? ( dev-util/gtk-doc
#		app-text/xmlto )"

src_unpack() {

	unpack ${A}
#	Fixed in the configure in a cleaner way.
#	use ppc && epatch ${FILESDIR}/gnu_asm_fix.patch
	# docs hack, disable dirs without html output
#	cd ${S}/docs
#	mv Makefile.in Makefile.in.old
#	sed -e "s:faq manual pwg::" Makefile.in.old > Makefile.in

}

src_compile() {

	elibtoolize

	strip-flags
	replace-flags "-O3" "-O2"

	# docs hack, circumvent xmltex check
	HAVE_XMLTEX=1 econf \
		--with-configdir=/etc/gstreamer \
		--disable-tests  \
		--disable-examples \
		--disable-docs-build \
		|| die "./configure failed"
#		`use_enable doc docs-build` \

	# On alpha, amd64 and hppa some innocuous warnings are spit out that break
	# the build because of -Werror
	use alpha && find . -name Makefile | xargs sed -i -e 's/-Werror//g'
	use amd64 && find . -name Makefile | xargs sed -i -e 's/-Werror//g'
	use hppa && find . -name Makefile | xargs sed -i -e 's/-Werror//g'

	emake || die "compile failed"

}

src_install() {

	einstall || die

	# remove the unversioned gst binaries
	# or they will be owned by several slots
	gst-plugins_remove_unversioned_binaries

	dodoc AUTHORS ChangeLog COPYING* DEVEL \
		NEWS README RELEASE REQUIREMENTS TODO

}

pkg_postinst() {

	gst-register-${PV_MAJ_MIN}

}
