# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/blt/blt-2.4z-r1.ebuild,v 1.2 2005/07/26 03:33:20 cretin Exp $

inherit eutils

SRC_URI="mirror://sourceforge/blt/BLT2.4z.tar.gz"
HOMEPAGE="http://blt.sf.net"
DESCRIPTION="BLT is an extension to the Tk toolkit adding new widgets, geometry managers, and miscellaneous commands."
DEPEND=">=dev-lang/tk-8.0"
IUSE=""
SLOT="0"
LICENSE="BSD"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"

S="${WORKDIR}/${PN}${PV}"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/blt2.4z-install.diff

	if [ "${ARCH}" = "amd64" -o "${ARCH}" = "ia64" ] ; then
		# From blt-2.4z-6mdk.src.rpm
		epatch ${FILESDIR}/blt2.4z-64bit.patch
	fi

	# Set the correct libdir
	sed -i -e "s:\(^libdir=\${exec_prefix}/\)lib:\1$(get_libdir):" \
		${S}/configure || die "sed failed"
}

src_compile() {
	cd ${S}
	./configure --host=${CHOST} \
				--prefix=/usr \
				--libdir=/usr/$(get_libdir) \
				--mandir=/usr/share/man \
				--infodir=/usr/share/info \
				--with-x \
				--with-tcl=/usr/$(get_libdir) || die "./configure failed"

	emake -j1 CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dodir /usr/bin \
		/usr/lib/blt2.4/demos/bitmaps \
		/usr/share/man/mann \
		/usr/include \
			|| die "dodir failed"
	make INSTALL_ROOT=${D} install || die "make install failed"

	dodoc NEWS PROBLEMS README
	for f in `ls ${D}/usr/share/man/mann` ; do
		mv ${D}/usr/share/man/mann/${f} ${D}/usr/share/man/mann/${f/.n/.nblt}
	done
}
