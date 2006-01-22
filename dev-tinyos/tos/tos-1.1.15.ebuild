# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tinyos/tos/tos-1.1.15.ebuild,v 1.1 2006/01/22 09:20:35 sanchan Exp $
inherit eutils

CVS_MONTH="Dec"
CVS_YEAR="2005"
MY_PN="tinyos"
MY_P=${MY_PN}-${PV}${CVS_MONTH}${CVS_YEAR}cvs

DESCRIPTION="TinyOS: an open-source OS designed for wireless embedded sensor networks"
HOMEPAGE="http://www.tinyos.net/"
SRC_URI="http://www.tinyos.net/dist-1.1.0/tinyos/source/${MY_P}.tar.gz"
LICENSE="Intel"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

#Ready to support doc regeneration when bug #113024 and #98029 will be resolved
#DEPEND="doc? ( sys-devel/m4
#	virtual/tetex
#	dev-tex/latex2html )"

DEPEND=""
RDEPEND=""

#Required to do anything useful. Could not be a RDEPEND since portage try to emerge nesc before tos.
PDEPEND="dev-tinyos/nesc"

S=${WORKDIR}/${MY_P}
src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/tos-1.1.15-system-AMStandard-Control.patch
	sed -i -e "s:psfig:epsfig:" ${S}/doc/schemadocsrc/tinyschema.tex \
		|| die "Error while updating tex sources."
	einfo "removing CVS dirs"
	for i in `find . -name CVS`; do
		rm -rf "${i}"
	done
}

src_compile() {
#Ready to support doc when bug #113024 and #98029 will be fixed
#	if use doc
#	then
#		cd ${WORKDIR}/tinyos-1.x/doc
#		make && make install-snapshots.html || die "Make error in tinyos-1.x/doc"
#		cd ${WORKDIR}/tinyos-1.x/doc/tex
#		make || die "Unable to make docs from tex sources"
#		cd ${WORKDIR}/tinyos-1.x/doc/schemadocsrc
#		make || die "Unable to make docs from tex sources"
#		make tinyschema.html || die "Unable to make docs from tex sources"
#	else
		einfo "Nothing to compile."
#	fi
}

src_install() {
	insinto /usr/src/tinyos-1.x
	doins -r tos

	# root group name doesn't exist on Mac OS X
	#NOTE: do not use fowners, as its not recursive ...
	# einfo "Fixing permissions ..."
	chown -R root:0 "${D}"

	# Note: should not die here or running in userpriv mode fill fail
	# portage autochanges ownership from portage to root.
	#	chmod -R u=rwX,go=rX "${D}"
	#	|| die "correcting file modes failed"
	dodoc ChangeLog
	if use doc
	then
		#once tetex works, tex could be removed.
		dohtml -A pdf,gif,tex -r doc/*
		dodoc doc/*.txt
	fi
	doenvd ${FILESDIR}/99tinyos
}

pkg_postinst() {
	einfo "If you want to use TinyOS on real hardware you need a cross compiler."
	einfo "You should emerge sys-devel/crossdev and compile any toolchain you need"
	einfo "Example: for Mica2 and Mica2 Dot: crossdev --target avr"
	ebeep 5
	epause 5
}

