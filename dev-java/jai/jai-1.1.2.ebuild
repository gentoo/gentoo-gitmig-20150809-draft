# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jai/jai-1.1.2.ebuild,v 1.1 2003/12/18 21:44:26 lostlogic Exp $

IUSE=""

At="jai-1_1_2-lib-linux-i586-jdk.bin"
S="${WORKDIR}/jai-1_2_2-lib-linux"
DESCRIPTION="Sun's Java(TM) Advanced Imaging API"
HOMEPAGE="http://java.sun.com/products/java-media/jai/index.jsp"
SRC_URI=${At}
SLOT="0"
LICENSE="sun-bcla-jai"
KEYWORDS="~x86 -ppc -sparc -alpha -mips -hppa -arm"
RESTRICT="fetch"

DEPEND="|| ( >=dev-java/sun-jdk-1.4 >=dev-java/sun-jre-1.4 )
	sys-apps/sed"

RDEPEND="${DEPEND}"

pkg_nofetch() {
	einfo "Please download ${At} from:"
	einfo ${HOMEPAGE}
	einfo "(from the JDK section select the Linux JDK Install option)"
	einfo "and move it to ${DISTDIR}"
}

src_unpack() {
	if [ ! -r ${DISTDIR}/${At} ]; then
		eerror "cannot read ${At}. Please check the permission and try again."
		die
	fi
	mkdir -p ${S}
	cd ${S}
	#Search for the ELF Header
	testExp=`echo -e "\177\105\114\106\001\001\001"`
	startAt=`grep -aonm 1 ${testExp}  ${DISTDIR}/${At} | cut -d: -f1`
	tail -n +${startAt} ${DISTDIR}/${At} > install.sfx
	chmod +x install.sfx
	./install.sfx || die
	rm install.sfx

#	if [ -f ${S}/lib/unpack ]; then
#		UNPACK_CMD=${S}/lib/unpack
#		chmod +x $UNPACK_CMD
#		for i in $PACKED_JARS; do
#			PACK_FILE=${S}/`dirname $i`/`basename $i .jar`.pack
#			if [ -f ${PACK_FILE} ]; then
#				echo "	unpacking: $i"
#				$UNPACK_CMD ${PACK_FILE} ${S}/$i
#				rm -f ${PACK_FILE}
#			fi
#		done
#	fi
}

find_home() {
	HOME=$(java-config --jre-home)
	if [ ! -d "${HOME}" ]; then
		HOME=$(java-config --jdk-home)/jre
	fi
	if [ "${HOME/sun}" == "${HOME}" ]; then
		HOME=/opt/$(java-config --list-available-vms|grep sun|head -n1|cut -f2 -d"["|cut -f1 -d"]")
		if [ "${HOME/jre}" == "${HOME}" ]; then
			HOME="${HOME}/jre"
		fi
	fi
	if [ ! -d "${HOME}" ]; then
		die "Unable to locate an appropriate location to install JAI"
	fi
}

src_install () {
	find_home
	dodir ${HOME}
	cp -a ${S}/jre/* ${D}/${HOME}
	dodoc COPYRIGHT-jai.txt README-jai.txt LICENSE-jai.txt INSTALL-jai.txt UNINSTALL-jai
}

pkg_postinst() {
	find_home
	einfo
	einfo "Installed jai into ${HOME}"
	einfo "This was the 'best selection' I could make for which"
	einfo "JVM to install JAI for, if this is not what you want"
	einfo "please use java-config to select the JVM of your choice"
	einfo "and remerge JAI after updating your environmnet"
	einfo
}
