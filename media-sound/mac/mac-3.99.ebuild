# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mac/mac-3.99.ebuild,v 1.1 2004/07/26 07:46:34 eradicator Exp $

IUSE=""

inherit flag-o-matic

DESCRIPTION="Monkey's Audio Lossless Codec (command-line tool and libs) for .ape files."
HOMEPAGE="http://www.monkeysaudio.com"
MY_P="${P}-u4"
S="${WORKDIR}/${MY_P}"
SRC_URI="mirror://gentoo/${MY_P}-linux.tar.gz"

LICENSE="MonkeysAudioSource"
SLOT="0"

#-*: nasm
#-amd64: segfaults on simple 'mac blah.ape -v'
KEYWORDS="-* ~x86 -amd64"
DEPEND="dev-lang/nasm
	sys-devel/libtool"

#RESTRICT="fetch"

#pkg_nofetch() {
#	einfo "The ${SRC_URI} file is a bit tricky to get. Please download it from:"
#	einfo "(a) http://www.maniac.nl/cms/filemanager.php"
#	einfo "(b) http://www.hydrogenaudio.org/forums/index.php?s=884c86cd87ae879e1e60dc4528d39de3&act=Attach&type=post&id=695"
#	einfo "Note: (a) is recommended. Otherwise please unzip mac_3.99.u4.zip."
#	einfo "Then you can move ${SRC_URI} to ${DISTDIR}."
#}

src_compile() {
	# Make gcc-3.4 stop complaining
	append-flags -fpermissive

	econf || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc NEWS AUTHORS src/Credits.txt src/History.txt
}
