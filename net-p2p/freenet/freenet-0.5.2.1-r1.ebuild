# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/freenet/freenet-0.5.2.1-r1.ebuild,v 1.3 2003/07/22 16:12:22 lostlogic Exp $

IUSE=""

S=${WORKDIR}/${PN}

DESCRIPTION="large-scale peer-to-peer network that creates a massive virtual information store open to anyone"
SRC_URI="mirror://sourceforge/freenet/${P}.tar.gz"
HOMEPAGE="http://freenetproject.org/"

SLOT="0"
KEYWORDS="x86 ~ppc"
LICENSE="GPL-2"

DEPEND="virtual/jre
	>=sys-apps/sed-4"

src_install() {
	dodoc README

        dodir /var/freenet/stats /var/freenet/store
	keepdir /var/freenet/stats /var/freenet/store

        insinto /usr/lib/freenet
        doins freenet.jar freenet-ext.jar

	insinto /etc/conf.d
	newins ${FILESDIR}/conf.freenet freenet

        exeinto /etc/init.d
        newexe ${FILESDIR}/rc.freenet freenet
}

pkg_postinst() {
	einfo "Congratulations on merging freenet, please run"
        einfo "# ebuild ${EBUILD} config"
	einfo "to update freenet to the latest jars and seednodes."
	einfo "This step is also necessary to configure freenet for"
	einfo "first use.  You may also run this step again at any time"
	einfo "to get any updates available to freenet"
}

pkg_postrm() {
	if [ -z has_version ]; then
	        einfo "Please remove /var/freenet manually if you are't going to"
	        einfo "continue to use Freenet on this machine!"
	fi
}

pkg_config() {
	YN="X"
	while [ "${YN}" != "y" -a "${YN}" != "Y" -a "${YN}" != "n" -a "${YN}" != "N" -a "${YN}" != "" ]; do
		echo "Would you like to update freenet files now? [Y/n]"
		read YN
	done
	if [ -z "$(echo ${YN}|sed -e s/y//i)" ];then
		wget http://freenetproject.org/snapshots/freenet-latest.jar -O /usr/lib/freenet/freenet.jar
		wget http://freenetproject.org/snapshots/seednodes.ref -O /var/freenet/seednodes.ref
		touch -d "1/1/1970" /var/freenet/seednodes.ref
	fi

	if [ ! -f /etc/freenet.conf ]; then
		einfo "Preparing to configure freenet..."
		# Pre-determine IP address
		IP="$(hostname -i)"
		declare -i DEFLP
		if [ "${RANDOM}" ]; then
			DEFLP=${RANDOM}%30000+2000
		else
			echo "no random in shell, enter a FNP port number + <ENTER>"
			read DEFLP
		fi
	
		cat << EOF > freenet.conf
ipAddress=${IP}
listenPort=${DEFLP}
seedFile=/var/freenet/seednodes.ref
logFile=/var/log/freenet.log
storeFile=/var/freenet/store
diagnosticsPath=/var/freenet/stats
routingDir=/var/freenet
nodeFile=/var/freenet/node
EOF
	
		CLASSPATH="/usr/lib/freenet/freenet.jar:/usr/lib/freenet/freenet-ext.jar:${CLASSPATH}"
		$(java-config --java) freenet.node.Main --config
		mv freenet.conf /etc
		sed -i -e "s/^%\(ipAddress\)/\1/" \
		       -e "s/^%\(listenPort\)/\1/" \
		       -e "s/^%\(seedFile\)/\1/" \
		       -e "s/^%\(logFile\)/\1/" \
		       -e "s/^%\(storeFile\)/\1/" \
		       -e "s/^%\(diagnosticsPath\)/\1/" \
		       -e "s/^%\(routingDir\)/\1/" \
		       -e "s/^%\(nodeFile\)/\1/" /etc/freenet.conf

	fi
	einfo "Congratulations, freenet is configured and up to date"
	einfo "use '/etc/init.d/freenet start' to start it"
}
