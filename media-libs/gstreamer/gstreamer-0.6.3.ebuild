# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gstreamer/gstreamer-0.6.3.ebuild,v 1.15 2004/03/19 07:56:03 mr_bones_ Exp $

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
KEYWORDS="x86 ppc sparc alpha amd64 ia64"

RDEPEND=">=dev-libs/glib-2.0.4
	>=dev-libs/libxml2-2.4
	>=dev-libs/popt-1.5
	x86? ( >=dev-lang/nasm-0.90 )
	>=sys-libs/zlib-1.1.4"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4"
#	doc? ( dev-util/gtk-doc )"

src_unpack() {

	unpack ${A}

	# proper gcc 3.3.1 fix (#27077)
	epatch ${FILESDIR}/${P}-gcc33.patch

	# patches to build with -Werror on ia64
	if use ia64; then
		epatch ${FILESDIR}/${PN}-0.6.3-Werror.patch
	fi

}

src_compile() {
	elibtoolize

	strip-flags
	replace-flags "-O3" "-O2"

	local myconf=""

# docs are broken once again
#	use doc \
#		&& myconf="${myconf} --enable-docs-build" \
#		|| myconf="${myconf} --disable-docs-build"
	myconf="${myconf} --disable-docs-build"

	econf \
		--program-suffix=-${PV_MAJ_MIN} \
		--with-configdir=/etc/gstreamer \
		--disable-tests  --disable-examples \
		${myconf} || die "./configure failed"

	# On alpha, amd64 and hppa some innocuous warnings are spit out that break
	# the build because of -Werror
	use alpha && find . -name Makefile | xargs sed -i -e 's/-Werror//g'
	use amd64 && find . -name Makefile | xargs sed -i -e 's/-Werror//g'
	use hppa && find . -name Makefile | xargs sed -i -e 's/-Werror//g'
	emake || die "compile failed"
}

src_install () {

	einstall || die "Installation failed"

	# fixes devhelp paths
	if [ -n "`use doc`" ] ;
	then
		cd ${S}/docs/devhelp
		for PDH in `ls *.devhelp` ;
		do
			mv ${PDH} ${PDH}.old
			sed -e "s:${D}::" ${PDH}.old > ${PDH}

			insinto /usr/share/gtk-doc/html/${PDH/.devhelp/}
			doins ${PDH}
		done
	fi

	dodoc AUTHORS ChangeLog COPYING* DEVEL NEWS \
		README RELEASE REQUIREMENTS TODO
}

pkg_postinst () {

	gst-register-${PV_MAJ_MIN}

}
