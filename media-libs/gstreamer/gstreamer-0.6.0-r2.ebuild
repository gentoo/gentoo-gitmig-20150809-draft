# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gstreamer/gstreamer-0.6.0-r2.ebuild,v 1.10 2004/03/19 07:56:03 mr_bones_ Exp $

inherit eutils flag-o-matic libtool

# Create a major/minor combo for our SLOT and executables suffix
PVP=($(echo " $PV " | sed 's:[-\._]: :g'))
PV_MAJ_MIN=${PVP[0]}.${PVP[1]}

IUSE="doc"

S=${WORKDIR}/${P}
DESCRIPTION="Streaming media framework"
SRC_URI="mirror://sourceforge/gstreamer/${P}.tar.bz2"
HOMEPAGE="http://gstreamer.sourceforge.net"

SLOT=${PV_MAJ_MIN}
LICENSE="LGPL-2"
KEYWORDS="x86 ppc sparc ~alpha"

DEPEND=">=dev-libs/glib-2.0.4
	>=dev-libs/libxml2-2.4
	>=dev-libs/popt-1.5
	x86? ( >=dev-lang/nasm-0.90 )
	>=sys-libs/zlib-1.1.4"

# disable docs for now
#	doc? ( >=dev-util/gtk-doc-0.9
#		media-gfx/transfig
#		dev-libs/libxslt
#		app-text/docbook-xsl-stylesheets
#		app-text/passivetex
#		app-text/xpdf
#		virtual/ghostscript )

src_unpack() {
	unpack ${A}

	cd ${S}
	# some extra error feedback
	epatch ${FILESDIR}/${PN}-error_report.patch

	# use 'opt' as our default scheduler it is new and has some
	# known problems but the default scheduler will crash on systems
	# with their glibc compiled for i386+, which means for about all
	# of our users :)
	# http://www.gstreamer.net/releases/0.6.0/notice.php
	#
	# foser <foser@gentoo.org>
	epatch ${FILESDIR}/${PN}-default_scheduler_opt.patch

	# Added patch for sparc.  Resolves bug #15502.  Thanks to
	# Alvaro Figueroa for pointing out the fix :)
	epatch ${FILESDIR}/${PN}-0.6.0-sparc.patch
}

src_compile() {
	elibtoolize

	strip-flags
	replace-flags "-O3" "-O2"

	local myconf=""
#	use doc \
#		&& myconf="${myconf} --enable-docs-build" \
#		|| myconf="${myconf} --disable-docs-build"
	myconf="${myconf} --disable-docs-build"

	econf \
		--program-suffix=-${PV_MAJ_MIN} \
		--with-configdir=/etc/gstreamer \
		--disable-tests  --disable-examples \
		${myconf} || die "./configure failed"

	emake || die "compile failed"
}

src_install () {
	einstall || die "Installation failed"

	dodoc AUTHORS ChangeLog COPYING* DEVEL NEWS \
		README RELEASE REQUIREMENTS TODO
}

pkg_postinst () {
	gst-register-${PV_MAJ_MIN}
}
