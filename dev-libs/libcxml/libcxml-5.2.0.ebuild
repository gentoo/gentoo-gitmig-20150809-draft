# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libcxml/libcxml-5.2.0.ebuild,v 1.1 2003/04/16 23:02:01 taviso Exp $

S=${WORKDIR}/usr
SRC_URI=""
DESCRIPTION="Compaqs eXtended Math Library for linux alpha"
HOMEPAGE="http://h18000.www1.hp.com/math/index.html"
DEPEND="virtual/glibc
		app-arch/rpm2targz
		dev-libs/libots
		dev-libs/libcpml"
RDEPEND="dev-libs/libots
		 dev-libs/libcpml"
LICENSE="compaq-sdla"
SLOT="0"
KEYWORDS="-* ~alpha"
IUSE="ev6 doc"

# non portage variable
RELEASE="5.2.0-2"
	
src_unpack() {
	local EV; use ev6 && EV=ev6 || EV=ev5
	At="cxml_${EV}-${RELEASE}.alpha.rpm"
	if [ ! -f ${DISTDIR}/${At} ] ; then
		die "Please download ${At} from ${HOMEPAGE}"
	fi

	# agriffis' improved method for rpm extraction
	# 
	i=${DISTDIR}/${At}
	dd ibs=`rpmoffset < ${i}` skip=1 if=$i 2>/dev/null \
		| gzip -dc | cpio -idmu 2>/dev/null \
		&& find usr -type d -print0 | xargs -0 chmod a+rx \
		&& chown -R root:root usr
	eend ${?}
	assert "Failed to extract ${At%.rpm}.tar.gz"

	if ! use doc >/dev/null ; then
		einfo "Removing unwanted documentation (USE=\"-doc\")..."
		rm -rf usr/doc
	else
		einfo "Reorganising Documentation..."
		mkdir usr/share
		mv usr/doc usr/share/
	fi
	
}

src_compile () {
	local EV; use ev6 && EV=ev6 || EV=ev5
	cd ${WORKDIR}/usr/lib/compaq/cxml-${RELEASE%*-2}

    # http://h18000.www1.hp.com/math/faq/cxml.html#EmptySharedLib
	ld -shared -o libcxml_${EV}.so -soname libcxml.so \ 
		-whole-archive libcxml_${EV}.a -no-whole-archive -lots -lcpml
}

src_install () {
	mv ${WORKDIR}/usr ${D}
	prepalldocs	
	einfo "Please wait while portage strips the libraries..."
	einfo "This may take a minute..."
}

