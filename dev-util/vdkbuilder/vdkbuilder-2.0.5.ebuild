# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/vdkbuilder/vdkbuilder-2.0.5.ebuild,v 1.1 2004/02/27 19:49:56 bass Exp $

IUSE="nls gnome"

DESCRIPTION="The Visual Development Kit used for VDK Builder."
SRC_URI="mirror://sourceforge/vdkbuilder/vdkbulder2-${PV}.tar.gz"
#SRC_URI="http://unc.dl.sourceforge.net/sourceforge/vdkbuilder/vdkbuilder2-2.0.5.tar.gz"
S="${WORKDIR}/${P/vdkbuilder/vdkbuilder2}"
HOMEPAGE="http://vdkbuilder.sf.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="dev-libs/vdk
		gnome? ( gnome-base/libgnome )"

src_compile() {

	local myconf

	# Allows vdkbuilder to compile on gcc3 systems.
	#epatch ${FILESDIR}/vdkbuilder-gcc3.patch || die "Patch Failed"

	use nls \
		&& myconf="${myconf} --enable-nls" \
		|| myconf="${myconf} --disable-nls"
	use gnome \
		&& myconf="${myconf} --enable-gnome=yes" \
		|| myconf="${myconf} --enable-gnome=no"

	econf ${myconf} || die "econf failed"
	emake || die
}

src_install () {
	einstall || die
	dodoc AUTHORS BUGS ChangeLog COPYING INSTALL NEWS README TODO
}
