# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/freenet/freenet-0.5.2.1-r7.ebuild,v 1.2 2004/01/31 12:33:04 mholzer Exp $

IUSE=""

S=${WORKDIR}/${PN}

DESCRIPTION="large-scale peer-to-peer network that creates a massive virtual information store open to anyone"
SRC_URI="mirror://sourceforge/freenet/${P}.tar.gz"
RESTRICT="nomirror"
HOMEPAGE="http://freenetproject.org/"

SLOT="0"
KEYWORDS="x86 ~ppc"
LICENSE="GPL-2"

DEPEND="virtual/jre
	>=sys-apps/sed-4
	app-admin/sudo"

src_install() {
	exeinto /usr/bin
	doexe ${FILESDIR}/start-freenet.sh

	dodoc README

	dodir /var/freenet/stats /var/freenet/store
	keepdir /var/freenet/stats /var/freenet/store

	insinto /usr/lib/freenet
	doins freenet.jar freenet-ext.jar

	insinto /etc/conf.d
	newins ${FILESDIR}/conf.freenet freenet

	exeinto /etc/init.d
	newexe ${FILESDIR}/rc.freenet5 freenet
}

pkg_preinst() {
	if ! groupmod freenet > /dev/null 2>&1; then
		groupadd freenet 2> /dev/null || \
		die "Failed to create freenet group"
	fi
	if ! usermod freenet > /dev/null 2>&1; then
		useradd -g freenet -s /bin/bash -d /var/empty \
			-c "freenet" freenet 2> /dev/null || \
			die "Failed to create freenet user"
	else
		usermod -s /bin/bash freenet
	fi
}

pkg_postinst() {
	if [ -f /etc/freenet.conf ];then
		chmod 664 /etc/freenet.conf
		chown root:freenet /etc/freenet.conf
	fi
	chown -R freenet:freenet /var/freenet
	einfo "Congratulations on merging freenet, please run"
	einfo "# ebuild ${EBUILD} config"
	einfo "to update freenet to the latest jars and seednodes."
	einfo "This step is also necessary to configure freenet for"
	einfo "first use.  You may also run this step again at any time"
	einfo "to get any updates available to freenet"
	ewarn "Anyone who merged a freenet prior to 0.5.2.1-r3 will"
	ewarn "need to change their logFile setting to /var/freenet/freenet.log"
	ewarn "in order for freenet to continue to function"
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
		einfo "Would you like to update freenet files now? [Y/n]"
		read YN
	done
	if [ -z "$(echo ${YN}|sed -e s/y//i)" ];then
		einfo "Press U within 2 seconds to try an unstable snapshot"
		read -n 1 -t 2 YN
		if [ "${YN}" == "U" ] || [ "${YN}" == "u" ]; then
			wget http://freenetproject.org/snapshots/freenet-unstable-latest.jar -O /usr/lib/freenet/freenet.jar
		else
			wget http://freenetproject.org/snapshots/freenet-latest.jar -O /usr/lib/freenet/freenet.jar
		fi
		wget http://freenetproject.org/snapshots/seednodes.ref -O /var/freenet/seednodes.ref
		touch -d "1/1/1970" /var/freenet/seednodes.ref
		chown freenet:freenet /var/freenet/seednodes.ref
	fi

	if [ -f /etc/freenet.conf ]; then
		einfo "Press C within 2 seconds to force reconfiguration of freenet"
		read -n 1 -t 2 YN
	fi
	if [ ! -f /etc/freenet.conf ] || [ "${YN}" == C ] || [ "${YN}" == "c" ]; then
		einfo "Preparing to configure freenet..."
		if [ -f /etc/freenet.conf ]; then
			cp /etc/freenet.conf .
		else
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
logFile=/var/freenet/freenet.log
storeFile=/var/freenet/store
diagnosticsPath=/var/freenet/stats
routingDir=/var/freenet
nodeFile=/var/freenet/node
EOF
		fi

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
		chmod 664 /etc/freenet.conf
		chown root:freenet /etc/freenet.conf
	fi
	einfo "Congratulations, freenet is configured and up to date"
	einfo "use '/etc/init.d/freenet start' to start it"
	einfo "You can always re-update/reconfigure  your freenet with:"
	einfo "# ebuild ${EBUILD} config"
}
