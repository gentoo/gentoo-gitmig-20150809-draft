# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ssddiff/ssddiff-0.2.ebuild,v 1.1 2008/05/19 10:22:30 flameeyes Exp $

ALIOTH_ID=1469

inherit eutils autotools

DESCRIPTION="A diff application for semi-structured data (such as XML files)"
HOMEPAGE="http://ssddiff.alioth.debian.org"
SRC_URI="http://alioth.debian.org/download.php/${ALIOTH_ID}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-libs/libxml2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}+gcc-4.3.patch"

	# Avoid collision with xmldiff
	sed -i -e 's/xmldiff/ssddiff/' src/Makefile.am \
		|| die "failed to rename binary"

	# These are symlinks in the original tarball, recreate them as
	# they point to automake 1.4 while we want, if possible, the
	# last version in portage, while not everybody will have automake
	# 1.4 available.
	rm "${S}"/{missing,config.{sub,guess},mkinstalldirs,install-sh}

	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README TODO AUTHORS NEWS ChangeLog
}
