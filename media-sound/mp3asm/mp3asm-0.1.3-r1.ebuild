# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3asm/mp3asm-0.1.3-r1.ebuild,v 1.2 2003/07/12 20:30:54 aliz Exp $

DESCRIPTION="A command line tool to clean and edit mp3 files."
HOMEPAGE="http://sourceforge.net/projects/mp3asm/"
MY_P=${PN}-${PV}-${PR/r/}
SRC_URI="mirror://sourceforge/mp3asm/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

IUSE=""
DEPEND=""
RDEPEND=""

# the author uses weird numbering...
S=${WORKDIR}/mp3asm-0.1

src_compile() {
        econf
        emake || die
}

src_install() {
        dodoc ${S}/README
        dodoc ${S}/COPYING
        dobin ${S}/src/mp3asm
}
