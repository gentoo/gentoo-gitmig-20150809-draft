# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmdf/wmdf-0.1.6-r1.ebuild,v 1.4 2007/07/22 05:14:12 dberkholz Exp $

inherit eutils

IUSE=""

DESCRIPTION="An app to monitor disk space on partitions"
SRC_URI="http://dockapps.org/download.php/id/359/${P}.tar.gz"
HOMEPAGE="http://dockapps.org/file.php/id/175"

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXt
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-proto/xextproto"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ppc64 ~sparc"

src_unpack() {
	unpack ${A}
	cd ${S}/src

	# Remove special filesystem entries, see bug #97856
	epatch ${FILESDIR}/wmdf_sys-fs.patch

	# Remove non-implemented command line args from 'wmdf -h' listing
	epatch ${FILESDIR}/wmdf_cmd_line_args.patch
}

src_compile() {
	econf || die "Configure failed"
	emake || die "Make failed"
}

src_install() {
	einstall || die "Install failed"
	dodoc README AUTHORS ChangeLog NEWS THANKS TODO
}
