# Copyright 1999-2005 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="ebay bidding Perl-Script"
HOMEPAGE="http://ebayagent.sf.net"
SRC_URI="mirror://sourceforge/ebayagent/eBayAgent-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE="tools"
KEYWORDS="x86"

DEPEND="dev-lang/perl
	>=dev-perl/libnet-1.16
	>=dev-perl/URI-1.35
	>=dev-perl/Crypt-SSLeay-0.49
	>=dev-perl/libwww-perl-5.79
	>=dev-perl/TimeDate-1.16"

S=${WORKDIR}/eBayAgent-${PV}

src_compile() {
	sed -i -e "s|PREFIX=/usr|PREFIX=${D}${DESTTREE}|" ${S}/Makefile
	
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
	if use tools; then
		
		# Patching eBayAgent_Skript
		# this will replace eBayAgent.pl with eBayAgent.
		# It also let the script read the settings for eBayAgent_Skript
		# from $HOME/.eBayAgent_Skript.config
		mv ${S}/Tools/eBayAgent_Skript ${S}/Tools/eBayAgent_Skript.old
		sed "s|eBayAgent.pl|eBayAgent|" ${S}/Tools/eBayAgent_Skript.old|sed -e '/fetching\ the\ data/'i"# Patched to read the settings from \$HOME/.eBayAgent_Skript.config\n# This will check if a config file exists. If not -> create\nif [ ! -e \$HOME/.eBayAgent_Skript.config ];then\n\tsed -n '/^# This is a simple/,/^ITEMS=/p' ${DESTTREE}/bin/eBayAgent_Skript > \$HOME/.eBayAgent_Skript.config\necho \"Please adjust \$HOME/.eBayAgent_Skript.config to your needs first\!\"\nexit\nfi\nsource \$HOME/.eBayAgent_Skript.config\n" > ${S}/Tools/eBayAgent_Skript
		dobin ${S}/Tools/repebay ${S}/Tools/runrepebay ${S}/Tools/eBayAgent_Skript
		doman ${S}/Tools/repebay.1 ${S}/Tools/runrepebay.1
		newdoc ${S}/Tools/README_First.txt README_First_Tools.txt 
		newdoc ${S}/Tools/README.Debian README_Tools.Debian
	fi
	
	# prepare manpages
	for mpage in $(find ${D} -name '*.1'|grep man);do
		gzip $mpage
	done
	
	dodoc COPYING INSTALL
	prepalldocs
}
