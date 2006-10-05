# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/bioapi/bioapi-1.2.2.ebuild,v 1.1 2006/10/05 13:39:49 wolf31o2 Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Framework for biometric-based authentication"
HOMEPAGE="http://www.bioapi.org"
SRC_URI="http://www.qrivy.net/~michael/blua/${PN}/${P}.tar.bz2"
LICENSE="bioapi"

SLOT="0"
KEYWORDS="~x86"
IUSE="qt"

#DEPEND=""
RDEPEND="${DEPEND}
		qt? ( >=x11-libs/qt-3 )"

src_compile() {
	VERGCC=$(gcc-version)
	if [ ${VERGCC} == 4.1 ]; then
		epatch ${FILESDIR}/bioapi-1.2.2_patch
	fi
	myconf="
		--host=${CHOST}\
		--prefix=/opt/bioapi \
		--sysconfdir=/etc \
		--localstatedir=/var \
		--libdir=/usr/$(get_libdir) \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man"

	if use qt; then
		myconf="${myconf} --with-Qt-dir=/usr/qt/3"
	else
		myconf="${myconf} --without-Qt-dir"
	fi

	econf $myconf || die "./configure failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	#and now we have to handle the docs
	dodoc README\
		00_License.htm \
		01_Readme.htm \
		09_Manifest.htm \
		10_Build.htm \
		11_Install.htm \
		12_Use.htm \
		20_Todo.htm \
		30_History.htm \
		31_Contributors.htm \
		32_Contacts.htm \
		Disclaimer
	insinto /opt/bioapi/include
	doins include/bioapi_util.h include/installdefs.h \
		imports/cdsa/v2_0/inc/cssmtype.h
	insinto /etc/env.d
	doins ${FILESDIR}/20bioapi
	insinto /etc/udev/rules.d
	doins ${FILESDIR}/51-bioapi.rules
}

pkg_postinst() {
	einfo "Running Module Directory Services (MDS) ..."
	/opt/bioapi/bin/mds_install -s /usr/lib || die " MDS failure"
	/opt/bioapi/bin/mod_install -fi /usr/lib/libbioapi100.so || die " mds bioapi100 failed"
	/opt/bioapi/bin/mod_install -fi /usr/lib/libbioapi_dummy100.so || die " mds bioapi_dummy100 failed"
	/opt/bioapi/bin/mod_install -fi /usr/lib/libpwbsp.so || die " mds pwbsp failed"
	
	if use qt; then
	    /opt/bioapi/bin/mod_install -fi /usr/lib/libqtpwbsp.so || die " mds qtpwbsp failed"
	fi

	enewgroup bioapi
	chgrp bioapi /var/bioapi -R
	chmod g+w,o= /var/bioapi -R
	einfo "Note: users using bioapi must be in group bioapi."
}

pkg_prerm() {
	einfo "Running Module Directory Services (MDS) ..."
	/opt/bioapi/bin/mod_install -fu libbioapi100.so
	/opt/bioapi/bin/mod_install -fu libbioapi_dummy100.so
	/opt/bioapi/bin/mod_install -fu libpwbsp.so
	
	if use qt; then
	    /opt/bioapi/bin/mod_install -fu libqtpwbsp.so
	fi

	einfo "You might want to remove the group bioapi."
	einfo "You might want to remove /var/bioapi."
}
