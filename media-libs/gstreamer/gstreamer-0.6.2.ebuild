# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gstreamer/gstreamer-0.6.2.ebuild,v 1.9 2004/03/23 19:16:53 mholzer Exp $

inherit eutils flag-o-matic libtool gnome.org

# Create a major/minor combo for our SLOT and executables suffix
PVP=($(echo " $PV " | sed 's:[-\._]: :g'))
PV_MAJ_MIN=${PVP[0]}.${PVP[1]}

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="Streaming media framework"
HOMEPAGE="http://gstreamer.sourceforge.net"

SLOT=${PV_MAJ_MIN}
LICENSE="LGPL-2"
KEYWORDS="x86 ppc ~sparc ~alpha ~amd64"

DEPEND=">=dev-libs/glib-2.0.4
	>=dev-libs/libxml2-2.4
	>=dev-libs/popt-1.5
	x86? ( >=dev-lang/nasm-0.90 )
	>=sys-libs/zlib-1.1.4"

#	doc? ( dev-util/gtk-doc )"

src_compile() {
	elibtoolize

	strip-flags
	replace-flags "-O3" "-O2"

	local myconf=""

# docs are broken once again
#	use doc \
#		&& myconf="${myconf} --enable-docs-build" \
#		|| myconf="${myconf} --disable-docs-build"

	econf \
		--program-suffix=-${PV_MAJ_MIN} \
		--with-configdir=/etc/gstreamer \
		--disable-tests  --disable-examples \
		${myconf} || die "./configure failed"

	emake || die "compile failed"
}

src_install () {
	einstall || die "Installation failed"

#	if [ -n "`use doc`" ] ;
#	then
#		cd ${S}/docs/devhelp
#		for PDH in `ls *.devhelp` ;
#		do
#			mv ${PDH} ${PDH}.old
#			sed -e "s:${D}::" ${PDH}.old > ${PDH}
#
#			insinto /usr/share/gtk-doc/html/${PDH/.devhelp/} 
#			doins ${PDH} 
#		done
#	fi

	dodoc AUTHORS ChangeLog COPYING* DEVEL NEWS \
		README RELEASE REQUIREMENTS TODO
}

pkg_postinst () {
	gst-register-${PV_MAJ_MIN}
}
