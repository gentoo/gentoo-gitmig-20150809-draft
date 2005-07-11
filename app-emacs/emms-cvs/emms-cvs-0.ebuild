# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/emms-cvs/emms-cvs-0.ebuild,v 1.1 2005/07/11 18:37:14 mkennedy Exp $

ECVS_AUTH="ext"
export CVS_RSH="ssh"
ECVS_SERVER="savannah.gnu.org:/cvsroot/emms"
ECVS_MODULE="emms"
if [ -z "${ECVS_BRANCH}" ]; then
	ECVS_BRANCH="HEAD"
fi
ECVS_USER="anoncvs"
# ECVS_PASS=""
ECVS_CVS_OPTIONS="-dP"
ECVS_SSH_HOST_KEY="savannah.gnu.org,199.232.41.3 ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAIEAzFQovi+67xa+wymRz9u3plx0ntQnELBoNU4SCl3RkwSFZkrZsRTC0fTpOKatQNs1r/BLFoVt21oVFwIXVevGQwB+Lf0Z+5w9qwVAQNu/YUAFHBPTqBze4wYK/gSWqQOLoj7rOhZk0xtAS6USqcfKdzMdRWgeuZ550P6gSzEHfv0="

inherit elisp cvs

DESCRIPTION="EMMS is the Emacs Multimedia System"
HOMEPAGE="http://www.gnu.org/software/emms/"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"
IUSE=""

DEPEND="virtual/emacs"

# EMMS can use almost anything for playing media files therefore the dependency
# posibilities are so broad that we refrain from setting anything explicitly in
# DEPEND/RDEPEND.

S="${WORKDIR}/emms"

src_compile() {
	make EMACS=emacs DESTDIR=/usr/share/emacs/site-lisp/emms-cvs || die
}

src_install() {
	elisp-install emms-cvs *.{el,elc}
	elisp-site-file-install ${FILESDIR}/50emms-cvs-gentoo.el
	dodoc AUTHORS README RELEASE
	doinfo *.info*
	dobin *-wrapper
}
