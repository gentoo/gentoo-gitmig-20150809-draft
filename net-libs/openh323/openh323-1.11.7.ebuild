# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/openh323/openh323-1.11.7.ebuild,v 1.4 2003/06/18 13:56:02 seemant Exp $

IUSE="ssl"

S=${WORKDIR}/${PN}
DESCRIPTION="Open Source implementation of the ITU H.323 teleconferencing protocol"
HOMEPAGE="http://www.openh323.org"
SRC_URI="http://www.openh323.org/bin/${PN}_${PV}.tar.gz"

SLOT="0"
LICENSE="MPL-1.1"
KEYWORDS="x86 ~ppc -sparc "

DEPEND=">=sys-apps/sed-4
	>=dev-libs/pwlib-1.4.11
	ssl? ( dev-libs/openssl )"

pkg_setup() {
	# to prevent merge problems with broken makefiles from old
	# pwlib versions, we double-check here.
	
	if [ "` fgrep '\$(OPENSSLDIR)/include' /usr/share/pwlib/make/unix.mak`" ]
	then
		# patch unix.mak so it doesn't require annoying 
		# unmerge/merge cycle to upgrade
		einfo "Fixing broken pwlib makefile."
		cd /usr/share/pwlib/make
		sed -i \
		-e "s:-DP_SSL -I\$(OPENSSLDIR)/include -I\$(OPENSSLDIR)/crypto:-DP_SSL:" \
		-e "s:^LDFLAGS.*\+= -L\$(OPENSSLDIR)/lib -L\$(OPENSSLDIR):LDFLAGS +=:" \
		unix.mak
	fi
}

src_compile() {
	export PWLIBDIR=/usr/share/pwlib
	export OPENH323DIR=${S}
	if [ "`use ssl`" ]; then
		export OPENSSLFLAG=1
		export OPENSSLDIR=/usr
		export OPENSSLLIBS="-lssl -lcrypt"
	fi
	make optshared || die
}

src_install() {

	dodir /usr/lib /usr/share/openh323

	cd ${S}/lib
	mv lib* ${D}/usr/lib

	cd ${S}
	find ./ -name 'CVS' -type d | xargs rm -rf
	cp -a * ${D}/usr/share/openh323

	# mod to keep gnugk happy
	insinto /usr/share/openh323/src
	newins ${FILESDIR}/openh323-1.11.2-emptyMakefile Makefile

	if [ ${ARCH} = "ppc" ] ; then
		dosym libh323_linux_ppc_r.so.${PV} /usr/lib/libopenh323.so
	else
		dosym libh323_linux_x86_r.so.${PV} /usr/lib/libopenh323.so
	fi


}


