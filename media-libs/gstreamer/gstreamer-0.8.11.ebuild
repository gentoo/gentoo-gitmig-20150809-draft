# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gstreamer/gstreamer-0.8.11.ebuild,v 1.11 2006/09/04 03:48:43 kumba Exp $

inherit eutils flag-o-matic libtool gnome2 flag-o-matic

# Create a major/minor combo for our SLOT and executables suffix
PVP=(${PV//[-\._]/ })
PV_MAJ_MIN=${PVP[0]}.${PVP[1]}

DESCRIPTION="Streaming media framework"
HOMEPAGE="http://gstreamer.sourceforge.net"
SRC_URI="http://gstreamer.freedesktop.org/src/gstreamer/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT=${PV_MAJ_MIN}
KEYWORDS="alpha amd64 ~arm hppa ia64 ppc ~ppc-macos ppc64 sparc x86"
IUSE="doc"

RDEPEND=">=dev-libs/glib-2.2
	>=dev-libs/libxml2-2.4.9
	>=dev-libs/popt-1.6.3"

DEPEND="${RDEPEND}
	>=sys-devel/gettext-0.11.5
	dev-util/pkgconfig
	doc? ( dev-util/gtk-doc
		=app-text/docbook-xml-dtd-4.2* )"

src_unpack() {

	unpack ${A}
	cd ${S}

	# Fix doc generation with jade. See bug #55700.
	epatch ${FILESDIR}/${PN}-0.8.3-jade_fix.patch

}

src_compile() {

	# FIXME : Ugly fix for docs generation gst cache problem (#57002)
	use doc && addpredict /var && addpredict /root

	elibtoolize

	strip-flags
	replace-flags "-O3" "-O2"
	replace-flags "-Os" "-O2"

	econf \
		--with-configdir=/etc/gstreamer \
		--disable-tests  \
		--disable-examples \
		--disable-valgrind \
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

	make DESTDIR=${D} install || die

	# remove the unversioned binaries gstreamer provide
	# this is to prevent these binaries to be owned by several SLOTs
	cd ${D}/usr/bin
	for gst_bins in `ls *-${PV_MAJ_MIN}`
	do
		rm ${gst_bins/-${PV_MAJ_MIN}/}
		einfo "Removed ${gst_bins/-${PV_MAJ_MIN}/}"
	done

	cd ${S}
	dodoc AUTHORS ChangeLog COPYING* DEVEL \
		NEWS README RELEASE REQUIREMENTS TODO

	dodir /etc/env.d/
	echo "PRELINK_PATH_MASK=/usr/lib/${PN}-${PV_MAJ_MIN}" > ${D}/etc/env.d/60${PN}-${PV_MAJ_MIN}

}

pkg_postinst() {

	gst-register-${PV_MAJ_MIN}

	einfo "Gstreamer has known problems with prelinking, as a workaround"
	einfo "this ebuild adds the gstreamer plugins to the prelink mask"
	einfo "path to stop them from being prelinked. It is imperative"
	einfo "that you undo & redo prelinking after building this pack for"
	einfo "this to take effect. Make sure the gstreamer lib path is indeed"
	einfo "added to the PRELINK_PATH_MASK environment variable."
	einfo "For more information see http://bugs.gentoo.org/show_bug.cgi?id=81512"

}
