# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/enlightenment.eclass,v 1.11 2004/02/03 00:01:45 vapier Exp $
#
# Author: vapier@gentoo.org

ECLASS=enlightenment
INHERITED="$INHERITED $ECLASS"

EXPORT_FUNCTIONS pkg_setup src_unpack src_compile src_install pkg_postinst

DESCRIPTION="A DR17 production"
HOMEPAGE="http://www.enlightenment.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
#	http://wh0rd.de/gentoo/distfiles/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64"
IUSE="nls doc"

DEPEND="doc? ( app-doc/doxygen )"
RDEPEND="nls? ( sys-devel/gettext )"

S=${WORKDIR}/${PN}

enlightenment_warning_msg() {
	if [ "${PV/2003}" != "${PV}" ] ; then
		ewarn "Please do not contact the E team about bugs in Gentoo."
		ewarn "Only contact vapier@gentoo.org via e-mail or bugzilla."
		ewarn "Remember, this stuff is CVS only code so dont cry when"
		ewarn "I break you :)."
	fi
}

enlightenment_pkg_setup() {
	enlightenment_warning_msg
}

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
	use hppa && append-flags -fPIC
	[ ! -z "${EHACKAUTOGEN}" ] && sed -i 's:.*configure.*::' autogen.sh
	env \
		PATH="${T}:${PATH}" \
		WANT_AUTOCONF_2_5=1 \
		NOCONFIGURE=yes \
		USER=blah \
		./autogen.sh \
		|| die "autogen failed"
	if [ ! -z "${EHACKLIBLTDL}" ] ; then
		cd libltdl
		env WANT_AUTOCONF_2_5=1 autoconf || die "autogen in libltdl failed"
		cd ..
	fi
	econf ${MY_ECONF} || die "econf failed"
	emake || die "emake failed"
	[ `use doc` ] && [ -x ./gendoc ] && { ./gendoc || die "gendoc failed" ; }
}

enlightenment_src_install() {
	make install DESTDIR=${D} || die
	find ${D} -name CVS -type d -exec rm -rf '{}' \; 2>/dev/null
	dodoc AUTHORS ChangeLog NEWS README TODO ${EDOCS}
	[ `use doc` ] && [ -d doc ] && dohtml -r doc/*
}

enlightenment_pkg_postinst() {
	enlightenment_warning_msg
}
