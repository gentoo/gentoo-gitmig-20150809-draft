#
# /usr/share/php-select/libapache.sh
#		Tool for managing Apache options on Gentoo Linux
#
# Author	Stuart Herbert
#		(stuart@gentoo.org)
#
# Copyright	(c) 2005 Gentoo Foundation, Inc.
#		Released under v2 of the GNU General Public License
#
# ========================================================================

actionSet ()
{
	setApacheConf $1
}

actionShow ()
{
	showApacheConf
}

actionTest ()
{
	testApacheConf
}

# ------------------------------------------------------------------------
# chooseApacheVersion () - select which version of Apache[2] will use
#
# $1 - PHP version to set
# $G_APACHE_CONF    - apache config file to edit
# $G_OPTS_VAR       - config variable to edit
# $G_APACHE_MOD_DIR - directory to look in for mod_php

chooseApacheVersion ()
{
	# convert the PHP version to upper-case
	chosen=$( echo $1 | tr [a-z] [A-Z] )

	# make a list of the mod_php versions available
	choices=( $(learnApacheMods $G_APACHE_MOD_DIR) )

	for (( i = 0 ; i < ${#choices[@]} ; i = i + 1 )) ; do
		if [[ ${choices[$i]} == $1 ]] ; then
			echo $chosen
		fi
	done
}

# ------------------------------------------------------------------------
# isInstalledForApache() - do we have any mod_php's installed for this
# version of Apache or not?

isInstalledForApache ()
{
	# find out which mod_php's are installed (if any!)
	choices=( $(learnApacheMods ${G_APACHE_MOD_DIR}) )

	# if there are no installed mod_php's, we tell the user
	if [[ -z $choices ]] ; then
		echo "*** error: mod_php is not installed for this version of Apache"
		G_EXITSTATUS=$G_STATUS_NOTINSTALLED
		return 1
	fi

	return 0
}

# ------------------------------------------------------------------------
# isUsingModPhp() - determine if Apache is configured to use mod_php or not

isUsingModPhp ()
{
	chosen=$(learnApacheConf ${G_APACHE_CONF})
	if [[ -z $chosen ]] ; then
		echo "No mod_php configured in $G_APACHE_CONF"
		G_EXITSTATUS=$G_STATUS_USINGNONE
		return 1
	fi

	return 0
}

# ------------------------------------------------------------------------
# learnApacheConf() - determine which PHP mod is set
#
# $1 - apache config file to examine

learnApacheConf ()
{
	. $1
	echo "${!G_OPTS_VAR}" | sed -e 's|^.*\(PHP[0-9]\).*|\1|;'
}

# ------------------------------------------------------------------------
# learnApacheMods() - learn which versions of mod_php are available for
# a chosen Apache version
#
# $1 - directory to search

learnApacheMods ()
{
	ls -1 $1/libphp*.so 2>/dev/null | sed -e 's|^.*lib\(php[0-9]\).*|\1|;'
}

# ------------------------------------------------------------------------
# setApacheConf () - set which version of Apache[2] will use
#
# $1 - PHP version to set
# $G_APACHE_CONF    - apache config file to edit
# $G_OPTS_VAR       - config variable to edit
# $G_APACHE_MOD_DIR - directory to look in for mod_php

setApacheConf ()
{
	isInstalledForApache || return 1

	# find out which option to set for Apache[2]
	#
	# if we can't find a matching mod_php to use, tell the user what
	# versions are available

	apacheChoice=$(chooseApacheVersion $1)
	if [[ -z $apacheChoice ]] ; then
		echo "*** error: compatible PHP version not found"
		echo "Compatible versions are:"
		echo
		for (( i = 0 ; i < ${#choices[@]} ; i = i + 1 )) ; do
			echo "* ${choices[$i]}"
		done

		G_EXITSTATUS=$G_STATUS_NOTCOMPATIBLE
		return
	fi
	
	# we know which version of mod_php we want to use
	#
	# create a new APACHE_OPTS variable

	. $G_APACHE_CONF
	newVar="$( echo ${!G_OPTS_VAR} | sed -e 's|-D PHP[0-9]||;' )"
	newVar="$( echo $newVar -D $apacheChoice | sed -e 's|  | |g;' )"

	# replace the old variable in the config file with the new one

	sed -e "s|$G_OPTS_VAR=.*|$G_OPTS_VAR=\"$newVar\"|;" -i $G_APACHE_CONF

	# remember to tell the user to restart apache!

	echo "Apache conf.d file updated.  For this change to take effect, you"
	echo "must restart the Apache webserver using this command:"
	echo
	echo "$G_APACHE_INIT restart"
}

# ------------------------------------------------------------------------
# showApacheConf() - show which version of PHP that Apache[2] is configured
# to use
#
# $G_APACHE_CONF - the Gentoo config file for Apache
# $G_OPTS_VAR    - the variable in the config file to check

showApacheConf ()
{
	isInstalledForApache || return 1

	# if we get here, then we have 1 or more mod_php's installed
	# 
	# find out which mod_php Apache is configured for (if any)

	isUsingModPhp || return 1

	# if we get here, then apache is configured for a mod_php ...
	# is it one that is installed?

	chosen="$( echo $chosen | tr [A-Z] [a-z] )"
	for (( i = 0 ; i < ${#choices[@]} ; i = i + 1 )) ; do
		if [[ ${choices[$i]} == $chosen ]] ; then
			echo $chosen
			return
		fi
	done

	# no, it is not installed
	# tell the user that they have a problem

	echo "*** warning: Apache is configured to use $chosen, but there is no"
	echo "             matching mod_php installed on this machine"
}

# ------------------------------------------------------------------------
# testApacheConf() - test which version of PHP that Apache[2] is configured
# to use
#
# $G_APACHE_CONF - the Gentoo config file for Apache
# $G_OPTS_VAR    - the variable in the config file to check

testApacheConf ()
{
	isInstalledForApache || return 1

	# if we get here, then we have 1 or more mod_php's installed
	# 
	# find out which mod_php Apache is configured for (if any)

	isUsingModPhp || return 1

	# if we get here, then apache is configured for a mod_php ...
	# is it one that is installed?

	chosen="$( echo $chosen | tr [A-Z] [a-z] )"
	for (( i = 0 ; i < ${#choices[@]} ; i = i + 1 )) ; do
		if [[ ${choices[$i]} == $chosen ]] ; then
			# we have one installed; but is it what we want?
			if [[ $chosen == $G_PHPVERSION ]]; then
				echo "Okay"
				return
			fi
			echo "*** warning: Apache is configured to use a different version of PHP"
			G_EXITSTATUS=$G_STATUS_USINGOTHER
			return 1
		fi
	done

	# no, it is not installed
	# tell the user that they have a problem

	echo "*** warning: Apache is configured to use $chosen, but there is no"
	echo "             matching mod_php installed on this machine"

	G_EXITSTATUS=$G_STATUS_NOTINSTALLED
}
