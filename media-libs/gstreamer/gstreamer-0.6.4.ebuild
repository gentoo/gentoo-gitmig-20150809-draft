# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gstreamer/gstreamer-0.6.4.ebuild,v 1.7 2004/01/29 04:55:49 agriffis Exp $

inherit eutils flag-o-matic libtool gnome.org

# Create a major/minor combo for our SLOT and executables suffix
PVP=($(echo " $PV " | sed 's:[-\._]: :g'))
PV_MAJ_MIN=${PVP[0]}.${PVP[1]}

DESCRIPTION="Streaming media framework"
HOMEPAGE="http://gstreamer.sourceforge.net"
LICENSE="LGPL-2"

SLOT=${PV_MAJ_MIN}
KEYWORDS="x86 ~ppc sparc alpha hppa ~amd64 ia64"
IUSE="doc"

RDEPEND=">=dev-libs/glib-2.0.4
	>=dev-libs/libxml2-2.4.9
	>=dev-libs/popt-1.6.1"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	dev-util/pkgconfig
	doc? ( dev-util/gtk-doc
		app-text/xmlto )"

src_unpack() {

	unpack ${A}
	use ppc && epatch ${FILESDIR}/gnu_asm_fix.patch
	# docs hack, disable dirs without html output
	cd ${S}/docs
	mv Makefile.in Makefile.in.old
	sed -e "s:faq manual pwg::" Makefile.in.old > Makefile.in

}

src_compile() {

	elibtoolize

	strip-flags
	replace-flags "-O3" "-O2"

	# docs hack, circumvent xmltex check
	HAVE_XMLTEX=1 econf \
		--program-suffix=-${PV_MAJ_MIN} \
		--with-configdir=/etc/gstreamer \
		--disable-tests  \
		--disable-examples \
		`use_enable doc docs-build` \
		|| die "./configure failed"

	# On alpha, amd64 and hppa some innocuous warnings are spit out that break
	# the build because of -Werror
	use alpha && find . -name Makefile | xargs sed -i -e 's/-Werror//g'
	use amd64 && find . -name Makefile | xargs sed -i -e 's/-Werror//g'
	use hppa && find . -name Makefile | xargs sed -i -e 's/-Werror//g'

	emake || die "compile failed"

}

src_install() {

	einstall || die

	dodoc AUTHORS ChangeLog COPYING* DEVEL \
		NEWS README RELEASE REQUIREMENTS TODO

}

pkg_postinst() {

	gst-register-${PV_MAJ_MIN}

}
