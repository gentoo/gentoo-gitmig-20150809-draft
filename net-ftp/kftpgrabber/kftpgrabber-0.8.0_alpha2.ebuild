# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/kftpgrabber/kftpgrabber-0.8.0_alpha2.ebuild,v 1.1 2006/10/09 20:33:09 deathwing00 Exp $

inherit kde eutils

MY_P="${P/_/-}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="A graphical FTP client for KDE."
HOMEPAGE="http://kftpgrabber.sourceforge.net/"
SRC_URI="http://www.kftp.org/uploads/files/${MY_P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="qsa howl"

DEPEND="dev-libs/openssl"
		#qsa? ( >=dev-libs/qsa-1.1.0 )

RDEPEND="${DEPEND}"

LANGS="bg br cs cy da de el en_GB es et fr ga gl hu it ja ka lt nl pl pt rw sk
sr sr@Latn sv tr zh_CN"

for X in ${LANGS} ; do
	IUSE="${IUSE} linguas_${X}"
done

need-kde 3.3

src_unpack() {
	kde_src_unpack

	local MAKE_LANGS
	cd "${WORKDIR}/${MY_P}/translations"
	for X in ${LANGS} ; do
		use linguas_${X} && MAKE_LANGS="${MAKE_LANGS} ${X}"
	done

	sed -i -e "s/SUBDIRS = bg br cs cy da de el en_GB es et fr ga gl hu it ja ka lt nl pl pt rw sk sr sr@Latn sv tr zh_CN/SUBDIRS= ${MAKE_LANGS}/" Makefile.in

}


