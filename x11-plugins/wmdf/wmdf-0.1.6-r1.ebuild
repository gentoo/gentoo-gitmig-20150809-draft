# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmdf/wmdf-0.1.6-r1.ebuild,v 1.1 2005/07/06 08:21:57 s4t4n Exp $

inherit eutils

IUSE=""

DESCRIPTION="An app to monitor disk space on partitions"
SRC_URI="http://dockapps.org/download.php/id/359/${P}.tar.gz"
HOMEPAGE="http://dockapps.org/file.php/id/175"

DEPEND="virtual/x11"

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
	dodoc README AUTHORS COPYING ChangeLog NEWS THANKS TODO INSTALL
}
