# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/dovecot-dspam/dovecot-dspam-0_beta7.ebuild,v 1.1 2007/06/18 12:26:07 hollow Exp $

inherit eutils autotools flag-o-matic multilib

DESCRIPTION="A statistical-algorithmic hybrid anti-spam filter"
HOMEPAGE="http://johannes.sipsolutions.net/Projects/dovecot-dspam-integration"
SRC_URI="http://dev.gentoo.org/~hollow/distfiles/${P}.c"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="net-mail/dovecot
	mail-filter/dspam"
RDEPEND="${DEPEND}"

KEYWORDS="~amd64 ~x86"

# we need this to prevent errors from dovecot-config
top_builddir() {
	return
}

src_unpack() {
	cp ${DISTDIR}/${P}.c ${WORKDIR}/${P}.c || die "could not copy source"
}

src_compile() {
	source ${ROOT}/usr/lib/dovecot/dovecot-config || \
	die "cannot find dovecot-config"

	$(tc-getCC) ${CFLAGS} -fPIC -shared \
	-I${dovecot_incdir} \
	-I${dovecot_incdir}/src \
	-I${dovecot_incdir}/src/lib \
	-I${dovecot_incdir}/src/lib-storage \
	-I${dovecot_incdir}/src/lib-mail \
	-I${dovecot_incdir}/src/lib-imap \
	-I${dovecot_incdir}/src/imap \
	-DHAVE_CONFIG_H \
	-DDSPAM=\"/usr/bin/dspam\" \
	-DSPAMFOLDER=\"Spam\" \
	-o ${WORKDIR}/lib99_dspam.so \
	${DISTDIR}/${P}.c || die "compilation failed"
}

src_install () {
	source ${ROOT}/usr/lib/dovecot/dovecot-config || \
	die "cannot find dovecot-config"

	insinto ${moduledir}/imap
	doins ${WORKDIR}/lib99_dspam.so
}
