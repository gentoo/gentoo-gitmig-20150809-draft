# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/afflib/afflib-3.3.4.ebuild,v 1.5 2009/05/01 19:02:17 armin76 Exp $

inherit eutils

DESCRIPTION="Library that implements the AFF image standard"
HOMEPAGE="http://www.afflib.org/"
SRC_URI="http://www.afflib.org/downloads/${P}.tar.gz"

LICENSE="BSD-4"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~s390 ~sparc ~x86"
IUSE="ewf fuse ncurses python qemu readline s3 threads"

DEPEND="
	ewf? ( app-forensics/libewf )
	fuse? ( sys-fs/fuse )
	ncurses? ( sys-libs/ncurses )
	python? ( dev-lang/python )
	readline? ( sys-libs/readline )
	s3? ( net-misc/curl dev-libs/expat )
	sys-libs/zlib
	dev-libs/openssl"
RDEPEND=${DEPEND}

src_compile() {
	econf \
		$(use_enable fuse) \
		$(use_enable ewf libewf) \
		$(use_enable python) \
		$(use_enable qemu) \
		$(use_enable s3) \
		$(use_enable threads threading)
	emake || die "build failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
	use s3 || {
		rm -f "${D}/usr/bin/s3"
	}
}
