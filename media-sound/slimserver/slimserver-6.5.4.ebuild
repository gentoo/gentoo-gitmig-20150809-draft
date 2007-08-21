# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/slimserver/slimserver-6.5.4.ebuild,v 1.1 2007/08/21 20:48:57 twp Exp $

inherit eutils

MY_P=SlimServer_v${PV}
DESCRIPTION="Slim Devices' SlimServer"
HOMEPAGE="http://www.slimdevices.com/slimserver/"
SRC_URI="http://www.slimdevices.com/downloads/${MY_P}/${MY_P}.no-cpan-arch.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="aac alac encode ffmpeg flac musepack ogg shorten"
DEPEND="sys-apps/findutils"
RDEPEND="
	>=dev-lang/perl-5.8.3
	>=virtual/mysql-5.0
	>=dev-perl/Compress-Zlib-1.41
	>=dev-perl/DBD-mysql-3.0007
	>=dev-perl/DBI-1.50
	>=dev-perl/Digest-SHA1-2.11
	dev-perl/GD
	>=dev-perl/HTML-Parser-3.48
	>=dev-perl/Template-Toolkit-2.14
	>=dev-perl/XML-Parser-2.34
	>=dev-perl/YAML-Syck-0.64
	>=net-misc/mDNSResponder-107
	>=virtual/perl-Time-HiRes-1.86
	aac? ( media-libs/faad2 )
	alac? ( media-sound/alac_decoder )
	encode? ( media-sound/lame )
	ffmpeg? ( media-video/ffmpeg )
	flac? ( media-libs/flac )
	musepack? ( media-sound/musepack-tools )
	ogg? ( media-sound/sox )
	shorten? ( media-sound/shorten )
	"
S="${WORKDIR}/${MY_P}"

pkg_setup() {
	if use ogg; then
		if ! built_with_use media-sound/sox ogg; then
			eerror "media-sound/sox not built with USE=ogg"
			die "media-sound/sox not built with USE=ogg"
		fi
	fi
	enewgroup slimserver || die
	enewuser slimserver -1 -1 /opt/slimserver slimserver || die
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/slimserver-bootstrap-gentoo.patch || die
	epatch ${FILESDIR}/slimserver-mDNSResponderPosix-107.patch || die
	rm Bin/build-perl-modules.pl
	rm CPAN/YAML/Syck.pm
	rm MySQL/errmsg.{sys,txt}
	#rm -rf MySQL
}

src_install() {
	# copy all files
	dodir /opt/slimserver
	cp -r * ${D}/opt/slimserver
	# initialize preferences file
	dodir /etc
	touch ${D}/etc/slimserver.prefs
	#password=$(gawk '$1 == "dbpassword:" { print $2 }' ${R}/etc/slimserver.prefs)
	#[[ -z "${password}" || "${password}" == "''" ]] \
	#	&& password="${RANDOM}.${RANDOM}.${RANDOM}.${RANDOM}"
	#cat <<EOF > ${D}/etc/slimserver.prefs
	#---
	#dbsource: dbi:mysql:database=slimserver
	#dbusername: slimserver
	#dbpassword: ${password}
	#EOF
	fowners slimserver:slimserver /etc/slimserver.prefs
	# create symbolic links to local mysql files
	dosym ../../../usr/sbin/mysqld /opt/slimserver/Bin/mysqld
	dosym ../../../usr/share/mysql/english/errmsg.sys \
		/opt/slimserver/MySQL/errmsg.sys
	dosym ../../../usr/share/mysql/errmsg.txt \
		/opt/slimserver/MySQL/errmsg.txt
	# create symbolic link to local mDNSResponderPosix
	dosym ../../../usr/sbin/mDNSResponderPosix \
		/opt/slimserver/Bin/mDNSResponderPosix
	# install init scripts
	newconfd ${FILESDIR}/slimserver.conf.d slimserver
	newinitd ${FILESDIR}/slimserver.init.d slimserver
	# initialize /var/{cache,run}
	keepdir /var/{cache,run}/slimserver
	fowners slimserver:slimserver /var/{cache,run}/slimserver
	# initialize /var/log
	dodir /var/log
	touch ${D}/var/log/slimserver
	fowners slimserver:slimserver /var/log/slimserver
}

pkg_postinst() {
	#elog "To create the SlimServer database, run"
	#elog "\temerge --config =${CATEGORY}/${PF}"
	elog "To start SlimServer, run"
	elog "\t/etc/init.d/slimserver start"
	elog "To start SlimServer automatically on boot, run:"
	elog "\trc-update add slimserver default"
	httpport=$(gawk '$1 == "httpport:" { print $2 }' ${R}/etc/slimserver.prefs)
	elog "To configure SlimServer, browse to:"
	elog "\thttp://localhost:${httpport:-9000}/"
}

#pkg_config() {
#	einfo "Enter your mysql root password:"
#	dbpassword=$(gawk '$1 == "dbpassword:" { print $2 }' ${R}/etc/slimserver.prefs)
#	[[ "$password" == "''" ]] && dbpassword=
#	mysql -u root -p <<EOF
#create database slimserver;
#grant all on slimserver.* to slimserver identified by '${dbpassword}';
#EOF
#}
