# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-java/blackdown-jdk/blackdown-jdk-1.4.1.ebuild,v 1.4 2003/05/24 06:35:35 absinthe Exp $

IUSE="doc"

inherit gcc java nsplugins

JREV="01"

S="${WORKDIR}/j2sdk${PV}"
DESCRIPTION="Blackdown Java Development Kit ${PV}"
J_URI="ftp://ftp.gwdg.de/pub/languages/java/linux/JDK-${PV}"
if [ "`gcc-major-version`" -eq "3" -a "`gcc-minor-version`" -ge "2" ] ; then
	SRC_URI="x86? ( ${J_URI}/i386/${JREV}/j2sdk-${PV}-${JREV}-linux-i586-gcc3.2.bin )"
else
	SRC_URI="x86? ( ${J_URI}/i386/${JREV}/j2sdk-${PV}-${JREV}-linux-i586-gcc2.95.bin )"
fi
SRC_URI="${SRC_URI} sparc? ( ${J_URI}/sparc/${JREV}/j2sdk-${PV}-${JREV}-linux-sparc-gcc3.2.bin )"

HOMEPAGE="http://www.blackdown.org"

SLOT="1.4.1"
LICENSE="sun-bcla-java-vm"
KEYWORDS="x86 -ppc sparc"

DEPEND="virtual/glibc
	>=dev-java/java-config-0.2.6
	doc? ( =dev-java/java-sdk-docs-1.4.1* )"

PROVIDE="virtual/jdk-1.4.1
	virtual/jre-1.4.1
	virtual/java-scheme-2"

# Extract the 'skip' value (offset of tarball) we should pass to tail
get_offset() {
	[ ! -f "$1" ] && return
        
	local offset="`gawk '
		/^[[:space:]]*skip[[:space:]]*=/ {

			sub(/^[[:space:]]*skip[[:space:]]*=/, "")
			SKIP = $0
		}
                
		END { print SKIP }
	' $1`"

	eval echo $offset
}

src_unpack () {
	local offset="`get_offset ${DISTDIR}/${A}`"

	if [ -z "${offset}" ] ; then
		eerror "Failed to get offset of tarball!"
		die "Failed to get offset of tarball!"
	fi

	echo ">>> Unpacking ${A}..."
	tail +${offset} ${DISTDIR}/${A} | tar --no-same-owner -jxp
}


src_install () {
	local PLATFORM=

	dodir /opt/${P}

	cp -a ${S}/{bin,jre,lib,man,include} ${D}/opt/${P}

	dodir /opt/${P}/share/java
	cp -a ${S}/{demo,src.zip} ${D}/opt/${P}/share
	
	dodoc COPYRIGHT LICENSE README INSTALL
	dohtml README.html

	# Install mozilla plugin
	if [ "${ARCH}" = "x86" ] ; then
		PLATFORM="i386"
	fi

	inst_plugin /opt/${P}/jre/plugin/${PLATFORM}/mozilla/javaplugin_oji.so 

	find ${D}/opt/${P} -type f -name "*.so" -exec chmod +x \{\} \;

	dosed "s/standard symbols l/symbol/g" \
		/opt/${P}/jre/lib/font.properties
	
	# install env into /etc/env.d
	set_java_env ${FILESDIR}/${VMHANDLE} || die
}

pkg_postinst () {
	# Set as default system VM if none exists
	java_pkg_postinst
}

