# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/enlightenment.eclass,v 1.2 2003/10/14 02:33:33 vapier Exp $
#
# Author: vapier@gentoo.org

ECLASS=enlightenment
INHERITED="$INHERITED $ECLASS"

EXPORT_FUNCTIONS src_unpack src_compile src_install

DESCRIPTION="A DR17 production"
HOMEPAGE="http://www.enlightenment.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://wh0rd.de/gentoo/distfiles/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64"
IUSE="nls"

DEPEND="nls? ( sys-devel/gettext )"

S=${WORKDIR}/${PN}

# the stupid gettextize script prevents non-interactive mode, so we hax it
gettext_modify() {
	use nls || return 0
	cp `which gettextize` ${T} || die "could not copy gettextize"
	cp ${T}/gettextize ${T}/gettextize.old
	sed -e 's:read dummy < /dev/tty::' ${T}/gettextize.old > ${T}/gettextize
}

enlightenment_src_unpack() {
	unpack ${A}
	gettext_modify
}

enlightenment_src_compile() {
	use alpha && append-flags -fPIC
	use ppc && append-flags -fPIC
	[ ! -z "${EHACKAUTOGEN}" ] && sed -i 's:.*configure.*::' autogen.sh
	env \
		PATH="${T}:${PATH}" \
		WANT_AUTOCONF_2_5=1 \
		NOCONFIGURE=yes \
		USER=blah \
		./autogen.sh \
		|| die "autogen failed"
	econf ${MY_ECONF} || die "econf failed"
	emake || die "emake failed"
}

enlightenment_src_install() {
	make install DESTDIR=${D} || die
	find ${D} -name CVS -type d -exec rm -rf '{}' \;
	[ -z "${EDOCS}" ] && EDOCS="AUTHORS ChangeLog NEWS README TODO"
	dodoc ${EDOCS}
	[ -d doc ] && dohtml -r doc/*
}
