# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cmt/cmt-1.20.20070720.ebuild,v 1.1 2007/09/15 13:14:47 bicatali Exp $

inherit elisp-common toolchain-funcs versionator

CPV=($(get_version_components ${PV}))
CMT_PV=v${CPV[0]}r${CPV[1]}p${CPV[2]}

DESCRIPTION="Cross platform configuration management environment"
HOMEPAGE="http://www.cmtsite.org/"
SRC_URI="http://www.cmtsite.org/${CMT_PV}/CMT${CMT_PV}.tar.gz"

LICENSE="CeCILL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="emacs java doc"

DEPEND=""
RDEPEND="emacs? ( virtual/emacs )
	java? ( virtual/jdk )"

RESTRICT="test"
S=${WORKDIR}/CMT/${CMT_PV}

src_compile() {
	cd mgr
	./INSTALL
	source setup.sh
	emake -j1 \
		cpp="$(tc-getCXX)" \
		cppflags="${CXXFLAGS}" \
		|| die "make failed"

	sed -i -e "s:${WORKDIR}:/usr/$(get_libdir):g" setup.*sh
	cd "${S}"
	mv src/demo .
	rm -f ${CMTBIN}/*.o
}

src_install() {
	CMTDIR=/usr/$(get_libdir)/CMT/${CMT_PV}
	dodir ${CMTDIR}
	cp -pPR mgr src ${CMTBIN} "${D}"/${CMTDIR}
	dodir /usr/bin
	dosym ${CMTDIR}/${CMTBIN}/cmt.exe /usr/bin/cmt

	echo "CMTROOT=\"${CMTDIR}\"" > 99cmt
	echo "CMTBIN=\"$(uname)-$(uname -m | sed -e 's# ##g')\"" >> 99cmt
	echo "CMTCONFIG=\"$(${CMTROOT}/mgr/cmt_system.sh)\"" >> 99cmt

	if use java; then
		cp -pPR java "${D}"/${CMTDIR}
		echo "#!/bin/sh" > jcmt
		echo "java cmt_parser" >> jcmt
		exeinto /usr/bin
		doexe jcmt
		echo "CLASSPATH=\"${CMTDIR}/java/cmt.jar\"" >> 99cmt
	fi

	doenvd 99cmt
	dodoc ChangeLog doc/*.txt || die "dodoc failed"
	dohtml doc/{ChangeLog,ReleaseNotes}.html || die "dohtml failed"

	if use doc; then
		cd "${S}"/mgr
		make gendoc || die "make gendoc failed"
		cd "${S}"/doc
		dohtml -r CMTDoc.html Images CMTFAQ.html || die "dohtml failed"
		doins -r demo || die "doins demo failed"
	fi

	use emacs && \
		elisp-site-file-install \
		doc/cmt-mode.el "${FILESDIR}"/80cmt-mode-gentoo.el
}

pkg_postinst () {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
