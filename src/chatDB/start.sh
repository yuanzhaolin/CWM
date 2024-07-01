ps -ef | grep chatdb-api.py | grep -v grep | awk '{print $2}' | xargs kill
python_path='/home/fashion/miniconda3/envs/chatdb/bin/python'
nohup $python_path -u chatdb-api.py >> chatdb-api.log 2>&1 &

