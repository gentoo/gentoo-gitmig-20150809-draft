# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/kftpgrabber/kftpgrabber-0.8.1-r1.ebuild,v 1.6 2007/09/02 08:35:57 nixnut Exp $

inherit kde

IUSE=""
LANGS="bg br cs cy da de el en_GB es et fr ga gl hu it ja ka lt nl pl pt rw sk
sr sr@Latn sv tr zh_CN"
for X in ${LANGS} ; do
	IUSE="${IUSE} linguas_${X}"
done

DESCRIPTION="A graphical FTP client for KDE."
HOMEPAGE="http://kftpgrabber.sourceforge.net/"
SRC_URI="http://www.kftp.org/uploads/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"

RDEPEND="dev-libs/openssl"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

need-kde 3.5

PATCHES="${FILESDIR}/kftpgrabber-0.8.1-inf-recursion-fix.diff"

src_unpack() {
	kde_src_unpack

	local MAKE_LANGS
	cd "${WORKDIR}/${P}/translations"
	for X in ${LANGS} ; do
		use linguas_${X} && MAKE_LANGS="${MAKE_LANGS} ${X}"
	done
	rm -f "${S}/configure"
	sed -i -e "s:SUBDIRS=.*:SUBDIRS=${MAKE_LANGS}:" Makefile.am
}
